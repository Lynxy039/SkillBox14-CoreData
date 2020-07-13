//
//  TableViewController.swift
//  Skillbox-14
//
//  Created by Антон Тимоненков on 01.07.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit

class CDTableViewController: UIViewController {
  weak var delegate: ShowButtonsDelegate?
  static let shareInstance = CDTableViewController()
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

extension CDTableViewController: UITableViewDataSource, UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return TaskPersistance.shared.allTasks().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CDToDoCell", for: indexPath) as! CDToDoTableViewCell
    let task = TaskPersistance.shared.allTasks()[indexPath.row].text
    cell.textLable.text = task
    cell.taskView.layer.cornerRadius = 15
    cell.taskView.backgroundColor = .systemGray6
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    if cell!.isSelected{
      CDTableViewController.shareInstance.selectedTasks.insert(indexPath.row)
    }
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    if !cell!.isSelected{
      CDTableViewController.shareInstance.selectedTasks.remove(indexPath.row)
    }
  }
}
