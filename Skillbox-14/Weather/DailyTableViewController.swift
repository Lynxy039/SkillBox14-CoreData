//
//  DailyTableViewController.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 21.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit

class DailyTableViewController: UIViewController {
  var count = 0
  var daily: [DailyWeather] = []
  var images: [Data?] = []
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.layer.cornerRadius = 20
    WeatherLoader().loadDailyWeather { daily, images in
      self.count = daily.count
      self.daily = daily
      self.images = images
      self.tableView.reloadData()
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
    if let image = images[indexPath.row + 1] { cell.dayImageView.image = UIImage(data: image)
    }
    cell.dateLable.text = dateFormatter(day.date, format: "EE")
    cell.descriptionLabel.text = day.description
    cell.dayTLabel.text = "☀\(day.dayT)"
    cell.feelsDayLabel.text = "☀\(day.feelsDay)"
    cell.nightTLabel.text = "☾\(day.nightT)"
    cell.feelsNightLabel.text = "☾\(day.feelsNight)"
    return cell
  }
}
