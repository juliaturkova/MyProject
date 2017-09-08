//
//  CoreDataTVC.swift
//  My Uber App ForRider
//
//  Created by julia on 07.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTVC: UITableViewController {
    
    @IBOutlet var tb: UITableView!
  
    
  //  @IBOutlet var tablevew: UITableView!
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
//title = "\"rating Of The Best Drivers\""
    //   tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    
    @IBAction func addName(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Driver", message: "Enter New Driver", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            let textField = alert.textFields?.first
            self.saveName(name: textField!.text!)
            self.tb.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveName(name: String) {
      
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let person = Person(entity: Person.entity(), insertInto: context)
        person.setValue(name, forKey: "name")
        
        do {
            
            try context.save()
            people.append(person)
        } catch let error as NSError {
            print ("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let result = try context.fetch(Person.fetchRequest())
            people = result as! [Person]
            
        } catch let error as NSError {
            print ("Could not save \(error), \(error.userInfo)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
let person = people[indexPath.row]
        cell.textLabel!.text = person.value(forKey: "name") as? String

        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        if editingStyle == .delete {
            context.delete(people[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            do {
                people = try context .fetch(Person.fetchRequest())
                
            } catch let error as NSError {
                print ("Could not save \(error), \(error.userInfo)")
            }
            
           tb.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
