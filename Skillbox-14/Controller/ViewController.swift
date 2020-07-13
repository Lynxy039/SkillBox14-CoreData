//
//  ViewController.swift
//  Skillbox-14
//
//  Created by Антон Тимоненков on 30.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  var person: NSManagedObject?

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var surnameTextField: UITextField!
  
  @IBAction func namePrinted(_ sender: Any) {
    Persistance.shared.name = nameTextField.text
  }
  @IBAction func surnamePrinted(_ sender: Any) {
    Persistance.shared.surname = surnameTextField.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let name = "123"
    print(person)
    save(name: name)
    print (person)
    nameTextField.text = Persistance.shared.name
    surnameTextField.text = Persistance.shared.surname
    
  }
  
  func save(name: String) {
    
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    // 1
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    // 2
    let entity =
      NSEntityDescription.entity(forEntityName: "PersonCD",
                                 in: managedContext)!
    
    let person = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    // 3
    person.setValue(name, forKeyPath: "name")
    
    // 4
    do {
      try managedContext.save()
      self.person = person
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
}

