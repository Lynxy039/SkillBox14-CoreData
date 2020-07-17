//
//  WeatherLoader.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 20.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire
import SwiftyJSON

class WeatherLoader{
  
  // MARK: - Parsing current weather with native metod
  func loadCurrentWeather(completion: @escaping (CurrentWeather, Data?) -> Void){
    SVProgressHUD.setBackgroundColor(UIColor.systemGray4)
    SVProgressHUD.show()
    AF.request("https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=f5c2903a599c6acbc6ee367b7324c6cf&lang=ru&units=metric").responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        if let weather = CurrentWeather(data: json){
          DispatchQueue.main.async {
            completion(weather, self.getImage(imageName: weather.imageName, scale: 2))
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  // MARK: - Parsing daily weather with Alamofire
  func loadDailyWeather(completion: @escaping ([DailyWeather], [Data?]) -> Void){
    AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=55.751244&lon=37.618423&exclude=current,hourly&appid=f5c2903a599c6acbc6ee367b7324c6cf&units=metric&lang=ru").responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        let array = json["daily"].arrayValue
        var daily: [DailyWeather] = []
        var images: [Data?] = []
        for data in array {
          if let day = DailyWeather(data: data){
            daily.append(day)
            images.append(self.getImage(imageName: day.imageName, scale: 2))
          }
        }
        DispatchQueue.main.async {
          SVProgressHUD.dismiss()
          completion(daily, images)
        }
      case .failure(let error):
          print(error)
      }
    }
  }
  
  func getImage(imageName: String, scale: Int) -> Data?{
    let url = URL(string: "https://openweathermap.org/img/wn/\(imageName)@\(scale)x.png")
    let data = try? Data(contentsOf: url!)
    return data
  }
}
