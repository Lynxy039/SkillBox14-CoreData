//
//  Persistance.swift
//  Skillbox-14
//
//  Created by Антон Тимоненков on 30.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation

class Persistance{
  static let shared = Persistance()
  
  let kNameKey = "Persistance.kNameKey"
  let kSurnameKey = "Persistance.kSurnameKey"
  
  var name: String? {
    set{ UserDefaults.standard.set(newValue, forKey: kNameKey)}
    get{return UserDefaults.standard.string(forKey: kNameKey)}
  }
  var surname: String? {
    set{ UserDefaults.standard.set(newValue, forKey: kSurnameKey)}
    get{return UserDefaults.standard.string(forKey: kSurnameKey)}
  }
}

