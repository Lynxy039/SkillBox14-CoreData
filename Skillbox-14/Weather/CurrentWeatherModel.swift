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

class CurrentWeather{
  var city: String
  var imageName: String
  var description: String
  var curT: Int
  var minT: Int
  var maxT: Int
  var feels: Int
  
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
    self.description = description
    self.curT = Int(curT)
    self.minT = Int(minT)
    self.maxT = Int(maxT)
    self.feels = Int(feels)
  }
  init?(realm: CurrentWeatherRealm){
    self.city = realm.city
    self.imageName = realm.imageName
    self.description = realm.description
    self.curT = Int(realm.curT)
    self.minT = Int(realm.minT)
    self.maxT = Int(realm.maxT)
    self.feels = Int(realm.feels)
  }
}
//class CurrentWeatherRealm: Object{
//  @objc dynamic var city: String = ""
//  @objc dynamic var imageName: String = ""
//  @objc dynamic var descript: String = ""
//  @objc dynamic var curT: Int = 0
//  @objc dynamic var minT: Int = 0
//  @objc dynamic var maxT: Int = 0
//  @objc dynamic var feels: Int = 0
//}
//class CurrentPersistance{
//  static let shared = CurrentPersistance()
//  
//  private let realm = try! Realm()
//  
//  func load() -> [CurrentWeatherRealm]{
//      var currentArray: [CurrentWeatherRealm] = []
//      let allCurrent = realm.objects(CurrentWeatherRealm.self)
//      for i in allCurrent {currentArray += [i]}
//      return currentArray
//  }
//
//  func save(_ forSave: [CurrentWeatherRealm]){
//    try! realm.write{
//      realm.delete(load())
//      realm.add(forSave)
//    }
//  }
//}
