//
//  DailyWeatherModel.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 21.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class DailyWeather: Object{
  @objc dynamic var date: Date
  @objc dynamic var imageName: String
  @objc dynamic var descript: String
  @objc dynamic var dayT: Int
  @objc dynamic var nightT: Int
  @objc dynamic var feelsDay: Int
  @objc dynamic var feelsNight: Int
  
  init?(data: JSON){
    guard let date = data["dt"].double,
      let imageName = data["weather",0,"icon"].string,
      let description = data["weather",0,"description"].string,
      let dayT = data["temp","day"].double,
      let nightT = data["temp","night"].double,
      let feelsDay = data["feels_like","day"].double,
      let feelsNight = data["feels_like","night"].double
    else {
      return nil
    }
  self.date = Date(timeIntervalSince1970: date)
  self.imageName = imageName
  self.descript = description
  self.dayT = Int(dayT)
  self.nightT = Int(nightT)
  self.feelsDay = Int(feelsDay)
  self.feelsNight = Int(feelsNight)
  }
  
  required init() {
    fatalError("init() has not been implemented")
  }
}
