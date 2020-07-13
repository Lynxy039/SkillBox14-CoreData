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

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var surnameTextField: UITextField!
  
  @IBAction func namePrinted(_ sender: Any) {
    CoreDataManager.instance.save(entityName: "PersonCD", att: "name", data: nameTextField.text)
//    Persistance.shared.name = nameTextField.text
  }
  @IBAction func surnamePrinted(_ sender: Any) {
    CoreDataManager.instance.save(entityName: "PersonCD", att: "surname", data: surnameTextField.text)
//    Persistance.shared.surname = surnameTextField.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let person = CoreDataManager.instance.fetchData("PersonCD")
    let name = person[0].value(forKeyPath: "name") as? String
    let surname = person[0].value(forKeyPath: "surname") as? String
    print(person.count)
    for i in person{
      print (i.value(forKeyPath: "name"),i.value(forKeyPath: "surname"))
    }
    nameTextField.text = name
    surnameTextField.text = surname
//    nameTextField.text = Persistance.shared.name
//    surnameTextField.text = Persistance.shared.surname
  }
}

