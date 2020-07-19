//
//  CurrentWeatherModel.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 20.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class CurrentWeather: Object{
  @objc dynamic var city: String = ""
  @objc dynamic var imageName: String = ""
  @objc dynamic var descript: String = ""
  @objc dynamic var curT: Int = 0
  @objc dynamic var minT: Int = 0
  @objc dynamic var maxT: Int = 0
  @objc dynamic var feels: Int = 0
  
  init?(data: JSON){
    guard let city = data["name"].string,
      let imageName = data["weather",0,"icon"].string,
      let description = data["weather",0,"description"].string,
      let curT = data["main","temp"].double,
      let minT = data["main","temp_min"].double,
      let maxT = data["main","temp_max"].double,
      let feels = data["main","feels_like"].double else {
      return nil
    }
    self.city = city
    self.imageName = imageName
    self.descript = description
    self.curT = Int(curT)
    self.minT = Int(minT)
    self.maxT = Int(maxT)
    self.feels = Int(feels)
  }  
  required init() {}
}
class CurrentWeatherPersistance{
  static let shared = CurrentWeatherPersistance()
  private let realm = try! Realm()
  
  func load() -> ([CurrentWeather]){
    var array: [CurrentWeather] = []
    let current = realm.objects(CurrentWeather.self)
    for i in current {
      array += [i]
    }
    return array
  }
  func save(_ forSave: CurrentWeather){
    let oldObject = realm.objects(CurrentWeather.self)
    try! realm.write{
      realm.delete(oldObject)
      realm.add(forSave)
    }
  }
}
