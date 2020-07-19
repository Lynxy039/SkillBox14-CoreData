//
//  ViewController.swift
//  Skillbox-14
//
//  Created by Антон Тимоненков on 30.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var surnameTextField: UITextField!

  
  @IBAction func namePrinted(_ sender: Any) {
    Persistance.shared.name = nameTextField.text
  }
  @IBAction func surnamePrinted(_ sender: Any) {
    Persistance.shared.surname = surnameTextField.text
  }
  //MARK: - close keyboard after press "Return" key
  @IBAction func doneName(_ sender: UITextField) {
    sender.resignFirstResponder()
  }
  @IBAction func doneSur(_ sender: UITextField) {
    sender.resignFirstResponder()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.text = Persistance.shared.name
    surnameTextField.text = Persistance.shared.surname
  }
}

