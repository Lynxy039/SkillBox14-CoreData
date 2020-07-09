//
//  TableViewController.swift
//  Skillbox-14
//
//  Created by Антон Тимоненков on 01.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit
protocol ShowButtonsDelegate: AnyObject {
  func showButton(_ value: Buttons)
}

class TableViewController: UIViewController {
  weak var delegate: ShowButtonsDelegate?
  static let shareInstance = TableViewController()
  var selectedTasks: Set<Int> = [] {
    didSet{
      if selectedTasks != []{
        self.delegate?.showButton(.del)
      }else{
        self.delegate?.showButton(.add)
      }
    }
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //MARK: - NC table reloader
    NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
  }
  @objc func reloadData(){
    self.tableView.reloadData()
  }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TaskPersistance.shared.allTasks().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
    let task = TaskPersistance.shared.allTasks()[indexPath.row].text
    cell.textLable.text = task
    cell.taskView.layer.cornerRadius = 15
    cell.taskView.backgroundColor = .systemGray6
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    if cell!.isSelected{
      TableViewController.shareInstance.selectedTasks.insert(indexPath.row)
    }
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    if !cell!.isSelected{
      TableViewController.shareInstance.selectedTasks.remove(indexPath.row)
    }
  }
}
