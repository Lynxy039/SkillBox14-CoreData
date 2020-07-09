//
//  TasksPersistance.swift
//  Skillbox-14
//
//  Created by Антон Тимоненков on 05.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object{
  @objc dynamic var text = ""
}

class TaskPersistance{
  static let shared = TaskPersistance()
  
  private let realm = try! Realm()
  
  func addTask(_ taskText: String){
    let task = Task()
    task.text = taskText
    try! realm.write{
      realm.add(task)
    }
  }
  
  func allTasks() -> [Task]{
    var taskArray: [Task] = []
    let allTasks = realm.objects(Task.self)
    for i in allTasks {taskArray += [i]}
    return taskArray
  }
  
  func delTasks(_ taskIndex: Set<Int>){
    let allTasks = realm.objects(Task.self)
    taskIndex.sorted(by: >).forEach ({ index in
      try! realm.write{
        realm.delete(allTasks[index])
      }
    })
  }
}
