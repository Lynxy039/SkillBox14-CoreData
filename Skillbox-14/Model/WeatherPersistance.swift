//
//  WeatherPersistance.swift
//  Skillbox-14-CoreData
//
//  Created by Антон Тимоненков on 17.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation
import RealmSwift

class CurrentWeatherRealm: Object{
  @objc dynamic var city: String = ""
  @objc dynamic var imageName: String = ""
  @objc dynamic var descript: String = ""
  @objc dynamic var curT: Int = 0
  @objc dynamic var minT: Int = 0
  @objc dynamic var maxT: Int = 0
  @objc dynamic var feels: Int = 0
}
class DailyWeatherRealm: Object{
  @objc dynamic var date: Date = Date()
  @objc dynamic var imageName: String = ""
  @objc dynamic var descript: String = ""
  @objc dynamic var dayT: Int = 0
  @objc dynamic var nightT: Int = 0
  @objc dynamic var feelsDay: Int = 0
  @objc dynamic var feelsNight: Int = 0
}

class WeatherPersistance{
  static let shared = WeatherPersistance()
  
  private let realm = try! Realm()
  
  func load() -> ([CurrentWeatherRealm], [Data?], [DailyWeatherRealm], [Data?]){
    var currentArray: [CurrentWeatherRealm] = []
    var dailyArray: [DailyWeatherRealm] = []
    var currentImages: [Data?] = []
    var dailyImages: [Data?] = []
    let current = realm.objects(CurrentWeatherRealm.self)
    let daily = realm.objects(DailyWeatherRealm.self)
    for i in current {
      currentArray += [i]
      currentImages += [getImage(imageName: i.imageName)]
    }
    for i in daily {
      dailyArray += [i]
      dailyImages += [getImage(imageName: i.imageName)]
    }
    return (currentArray, currentImages, dailyArray, dailyImages)
  }

  func save(_ forSave: ([CurrentWeatherRealm], [DailyWeatherRealm])){
    let (current, daily) = forSave
    let (oldCurrent, _, oldDaily, _) = self.load()
    try! realm.write{
      realm.delete(oldCurrent)
      realm.delete(oldDaily)
      realm.add(current)
      realm.add(daily)
    }
  }
  func getImage(imageName: String) -> Data?{
    let url = URL(string: "https://openweathermap.org/img/wn/\(imageName)@2x.png")
    let data = try? Data(contentsOf: url!)
    return data
  }
}

//class DailyPersistance{
//  static let shared = DailyPersistance()
//
//  private let realm = try! Realm()
//
//  func load() -> [DailyWeatherRealm]{
//      var dailyArray: [DailyWeatherRealm] = []
//      let allDaily = realm.objects(DailyWeatherRealm.self)
//      for i in allDaily {dailyArray += [i]}
//      return dailyArray
//  }
//
//  func save(_ forSave: [DailyWeatherRealm]){
//    try! realm.write{
//      realm.delete(self.load())
//      realm.add(forSave)
//    }
//  }
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
