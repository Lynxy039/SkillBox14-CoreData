//
//  CoreDataManager.swift
//  Skillbox-14-CoreData
//
//  Created by Антон Тимоненков on 13.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation
import CoreData

class  CoreDataManager {
  static let instance = CoreDataManager()
  
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Skillbox-14-CoreData")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  lazy var context: NSManagedObjectContext = {
    return persistentContainer.viewContext
  }()

  // MARK: - Core Data Saving support
  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
//   Entity for Name
  func entityForName(entityName: String) -> NSEntityDescription {
    return NSEntityDescription.entity(forEntityName: entityName, in: self.context)!
  }
}
