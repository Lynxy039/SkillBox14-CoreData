//
//  ViewController.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 20.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit
import Kingfisher

class CurrentViewController: UIViewController {
  @IBOutlet weak var cityLable: UILabel!
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var descriptionLable: UILabel!
  @IBOutlet weak var curTLable: UILabel!
  @IBOutlet weak var minTLable: UILabel!
  @IBOutlet weak var maxTLable: UILabel!
  @IBOutlet weak var feelsLable: UILabel!
  @IBOutlet weak var currentView: UIView!
  @IBOutlet weak var tempView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    currentView.layer.cornerRadius = 30
    tempView.layer.cornerRadius = 15
    let current = CurrentWeatherPersistance.shared.load()[0]
    self.assigment(current)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    WeatherLoader().loadCurrentWeather { weather in
      self.assigment(weather)
      CurrentWeatherPersistance.shared.save(weather)
    }
  }
  func assigment(_ weather: CurrentWeather){
    self.cityLable.text = weather.city + ", " + dateFormatter(Date(), format: "MMMMdEE")
    let url = URL(string: "https://openweathermap.org/img/wn/\(weather.imageName)@2x.png")
    self.weatherImageView.kf.setImage(with: url)
    self.descriptionLable.text = weather.descript
    self.curTLable.text = "\(weather.curT)℃"
    self.minTLable.text = "\(weather.minT)"
    self.maxTLable.text = "\(weather.maxT)"
    self.feelsLable.text = "ощущается как \(weather.feels)℃"
  }
}
