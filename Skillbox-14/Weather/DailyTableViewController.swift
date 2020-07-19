//
//  DailyTableViewController.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 21.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

class DailyTableViewController: UIViewController {
  var count = 0
  var daily: [DailyWeather] = []
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.layer.cornerRadius = 20
    self.daily = DailyWeatherPersistance.shared.load()
    self.count = daily.count
    self.tableView.reloadData()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    WeatherLoader().loadDailyWeather { daily in
      self.count = daily.count
      self.daily = daily
      self.tableView.reloadData()
      DailyWeatherPersistance.shared.save(daily)
    }
  }
}

extension DailyTableViewController: UITableViewDataSource, UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.count - 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayTableViewCell
    let day = daily[indexPath.row + 1]
    let url = URL(string: "https://openweathermap.org/img/wn/\(day.imageName)@2x.png")
    cell.dayImageView.kf.setImage(with: url)
    cell.dateLable.text = dateFormatter(day.date, format: "EE")
    cell.descriptionLabel.text = day.descript
    cell.dayTLabel.text = "☀\(day.dayT)"
    cell.feelsDayLabel.text = "☀\(day.feelsDay)"
    cell.nightTLabel.text = "☾\(day.nightT)"
    cell.feelsNightLabel.text = "☾\(day.feelsNight)"
    return cell
  }
}
