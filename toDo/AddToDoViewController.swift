//
//  AddToDoViewController.swift
//  toDo
//
//  Created by West Kraemer on 11/11/17.
//  Copyright © 2017 West Kraemer. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {
    
    var previousVC = ToDoTableViewController()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var importantSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addTapped(_ sender: Any) {
        let toDo = ToDo()
        
        /*if let means that if you can assign titleTextField.text to a variable, then you can then work with it. If it can be assigned to a variable, that means it's not nil. */
        if let titleText = titleTextField.text {
            toDo.name = titleText
            toDo.important = importantSwitch.isOn
            
            previousVC.toDos.append(toDo)
            previousVC.tableView.reloadData()
            
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}
