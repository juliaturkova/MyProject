//
//  add NewDriverVC.swift
//  My Uber App ForRider
//
//  Created by julia on 01.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit
import CoreData

class add_NewDriverVC: UIViewController {
    
    var people = [NSManagedObject]()
    
    @IBOutlet weak var nameField: UITextField!
    
    
    
    @IBOutlet weak var carField: UITextField!
    
    
    
    @IBOutlet weak var noteField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//

    
    @IBAction func addNewDriverButton(_ sender: Any) {
        
      
       let nameText = nameField.text!
       let carText = carField.text!
       let noteText = noteField.text!
        
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
//        
//        let newName = DriverNameTop(context: context)
//        newName.name = nameField.text!
//        newName.car = carField.text!
//        newName.note = noteField.text!
        
        
        let entity = NSEntityDescription.entity(forEntityName: "DriverNameTop", in: context)
        let user = NSManagedObject(entity: entity!, insertInto: context)

        user.setValue(nameText, forKey: "name")
        user.setValue(carText, forKey: "car")
        user.setValue(noteText, forKey: "note")
        user.setValue(NSDate(), forKey: "date")

        do {
            try context.save()
            people.append(user)
            
        } catch {
             let nserror = error as NSError
            print("Could Not Save \(nserror), \(nserror.userInfo)")
        
        }
     self.dismiss(animated: true, completion: nil)
            

    
    }


} //class

