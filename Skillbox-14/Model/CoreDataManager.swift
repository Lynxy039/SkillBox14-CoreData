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
  let entityName = "TaskCD"
  let att = "text"
  let appDelegate = UIApplication.shared.delegate as? AppDelegate
  func context() -> NSManagedObjectContext?{
    guard let appDelegate = appDelegate else {return nil}
    return appDelegate.persistentContainer.viewContext
  }
  func saveData(data: String?) {
    guard let managedContext = context(), let appDelegate = appDelegate else {return}
    let entity =
      NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
    let object = NSManagedObject(entity: entity, insertInto: managedContext)
    object.setValue(data, forKeyPath: att)
    appDelegate.saveContext()
  }
  func deleteObject(_ taskIndex: Set<Int>){
    guard let managedContext = context(), let appDelegate = appDelegate else {return}
    var data: [NSManagedObject] = []
    data = fetchData()
    taskIndex.sorted(by: >).forEach ({ index in
      managedContext.delete(data[index])
    })
    appDelegate.saveContext()
  }
  func fetchData() -> [NSManagedObject]{
    var data: [NSManagedObject] = []
    guard let managedContext = context() else {return []}
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
    do {
      data = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    return data
  }
}
