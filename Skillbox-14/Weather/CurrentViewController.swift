//
//  ViewController.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 20.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit

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
    
    WeatherLoader().loadCurrentWeather { weather, image in
      self.cityLable.text = weather.city + ", " + dateFormatter(Date(), format: "MMMMdEE")
      if let image = image {
        self.weatherImageView.image = UIImage(data: image)
      }
      self.descriptionLable.text = weather.description
      self.curTLable.text = "\(weather.curT)℃"
      self.minTLable.text = "\(weather.minT)"
      self.maxTLable.text = "\(weather.maxT)"
      self.feelsLable.text = "ощущается как \(weather.feels)℃"
    }
  }
}
