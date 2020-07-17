//
//  DateFormatter.swift
//  Skillbox 12
//
//  Created by Антон Тимоненков on 23.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation

public func dateFormatter(_ date: Date, format: String) -> String{
  let dateFormatter = DateFormatter()
  dateFormatter.locale = Locale(identifier: "ru_MD")
  dateFormatter.setLocalizedDateFormatFromTemplate(format)
  return dateFormatter.string(from: date)
}
