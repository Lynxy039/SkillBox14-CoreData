//
//  ToDoViewController.swift
//  Skillbox-14
//
//  Created by Антон Тимоненков on 01.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit

class CDToDoViewController: UIViewController {
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var taskBottomConst: NSLayoutConstraint!
  @IBOutlet weak var addTaskButton: UIButton!
  @IBOutlet weak var delTaskButton: UIButton!
  
  @IBAction func enterTask(_ sender: Any) {
    guard let task = taskTextField.text else {
      showButton(.add)
      return
    }
    if task != ""{
//      TaskPersistance.shared.addTask(task)
      CoreDataManager.instance.saveData(data: task)
    }
    reloadTableView()
    showButton(.add)
  }
  
  @IBAction func addTask(_ sender: Any) {
    showButton(.enter)
    taskTextField.becomeFirstResponder()
  }
  
  @IBAction func delTask(_ sender: Any) {
    if !CDTableViewController.shareInstance.selectedTasks.isEmpty{
      CoreDataManager.instance.deleteObject(CDTableViewController.shareInstance.selectedTasks)
      CDTableViewController.shareInstance.selectedTasks = []
    }
    reloadTableView()
    showButton(.add)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    CDTableViewController.shareInstance.delegate = self
    showButton(.add)
    //MARK: - NC for keyboard
    NotificationCenter.default.addObserver(self,
    selector: #selector(self.keyboardNotification(notification:)),
    name: UIResponder.keyboardWillChangeFrameNotification,
    object: nil)
  }
  
  deinit {
      NotificationCenter.default.removeObserver(self)
  }
  
  func reloadTableView(){
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
  }
}

extension CDToDoViewController: ShowButtonsDelegate{
  func showButton(_ value: Buttons){
    switch value {
    case .add:
      addTaskButton.isHidden = false
      taskTextField.isHidden = true
      delTaskButton.isHidden = true
    case .enter:
      addTaskButton.isHidden = true
      taskTextField.isHidden = false
      delTaskButton.isHidden = true
    case .del:
      addTaskButton.isHidden = true
      taskTextField.isHidden = true
      delTaskButton.isHidden = false
    }
  }
}
extension CDToDoViewController{
  //MARK:- Animate bottom menu when keyboard open
  @objc func keyboardNotification(notification: NSNotification) {
    if let userInfo = notification.userInfo {
      let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
      let endFrameY = endFrame?.origin.y ?? 0
      let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
      let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
      let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
      let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
      let tabHeight = self.tabBarController?.tabBar.frame.height ?? 49.0
      if endFrameY >= UIScreen.main.bounds.size.height {
          self.taskBottomConst?.constant = 10.0
      } else {
        self.taskBottomConst?.constant = (endFrame?.size.height)! - tabHeight + 10
      }
      UIView.animate(withDuration: duration,
        delay: TimeInterval(0),
        options: animationCurve,
        animations: { self.view.layoutIfNeeded() },
        completion: nil)
    }
  }
}
