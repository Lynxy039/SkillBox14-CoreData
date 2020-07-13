//
//  Person+CoreDataClass.swift
//  Skillbox-14-CoreData
//
//  Created by Антон Тимоненков on 13.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
  convenience init() {
      self.init(entity: CoreDataManager.instance.entityForName("Person"), insertIntoManagedObjectContext: CoreDataManager.instance.managedObjectContext)
  }
}
