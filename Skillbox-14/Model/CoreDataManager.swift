//
//  CoreDataManager.swift
//  Skillbox-14-CoreData
//
//  Created by Антон Тимоненков on 13.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class  CoreDataManager {
  static let instance = CoreDataManager()

//  private init() {}

  func save(entityName: String?, att: String?, data: String?) {
    
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    guard let entityName = entityName, let data = data, let att = att else {return}
    // 1
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    // 2
    let entity =
      NSEntityDescription.entity(forEntityName: entityName,
                                 in: managedContext)!
    
    let object = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3
    object.setValue(data, forKeyPath: att)
    print (object)

    
    // 4
    appDelegate.saveContext()
//    do {
//      try managedContext.save()
//    } catch let error as NSError {
//      print("Could not save. \(error), \(error.userInfo)")
//    }
  }
  func deleteObject(entityName: String?){
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    guard let entityName = entityName else {return}
    let managedContext =
    appDelegate.persistentContainer.viewContext
    let entity =
    NSEntityDescription.entity(forEntityName: entityName,
                               in: managedContext)!
    let object = NSManagedObject(entity: entity,
    insertInto: managedContext)
    managedContext.delete(object)
  }
  func fetchData(_ entity: String) -> [NSManagedObject]{
    var data: [NSManagedObject] = []
    //1
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return []
    }
    
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    //2
    let fetchRequest =
      NSFetchRequest<NSManagedObject>(entityName: entity)
    
    //3
    do {
      data = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    return data
  }
}
