//
//  ToDoTableViewController.swift
//  toDo
//
//  Created by West Kraemer on 11/10/17.
//  Copyright © 2017 West Kraemer. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    //this array will hold ToDo objects and begins as being empty. When createToDoos is called as a function, then it returns the properties within the array created by the createToDos function.
    var toDos : [ToDoCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getToDos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataToDos = try? context.fetch(ToDoCoreData.fetchRequest()) as? [ToDoCoreData] {
                if let theToDos = coreDataToDos {
                    toDos = theToDos
                    tableView.reloadData()
                }
            }
            
            
        }
    }
    
    func createToDos() -> [ToDo] {
        
        let eggs = ToDo()
        eggs.name = "Buy Eggs"
        eggs.important = true
        
        let dog = ToDo()
        dog.name = "Luna"
        dog.important = true
        
        let cheese = ToDo()
        cheese.name = "American"
        cheese.important = false
        
        return [eggs, dog, cheese]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let indexPathList = toDos[indexPath.row]
        
        if let name = indexPathList.name {
            
            if indexPathList.important {
                cell.textLabel?.text = "❗️" + name
            } else {
                cell.textLabel?.text = indexPathList.name
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathList = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: indexPathList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController {
            
            if let toDo = sender as? ToDoCoreData {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
        
    }
    
}
