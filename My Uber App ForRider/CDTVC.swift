//
//  CDTVC.swift
//  My Uber App ForRider
//
//  Created by julia on 08.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit
import  CoreData

class CDTVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //var categoriesTableView = [["name": "The Best Driver", "image": "1-pic", "subName": "Raiting Of The Best Drivers"], ["name": "My Rating", "image": "2-pic", "subName": "Raiting Of The Best Riders"], ["name": "My Trips", "image": "3-pic", "subName": "All My Trip By Uber"], ["name": "Photo", "image": "4-pic", "subName": "Photo Collection"]]
    
    var menuStuff = [CustomMenuStuff]()
    
   // var identity = [String]()
    
    
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iconImageView = UIImageView(image: UIImage(named: "IronManImage"))
        self.navigationItem.titleView = iconImageView
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
       // identity = ["A", "B", "C", "D"]
        
        
        
        // return managedObjectContext and right now we can use as property
        
        loadData()
        
        
        
    }
    
    func loadData(){
        
        let menuRequest: NSFetchRequest<CustomMenuStuff> = CustomMenuStuff.fetchRequest()
        
        do {
            menuStuff = try managedObjectContext!.fetch(menuRequest)
            self.tableView.reloadData()
        } catch {
            
            print("Could Not Load Data From Database \(error.localizedDescription)")
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return (categoriesTableView.count + menuStuff.count)
         return menuStuff.count
        
        //return categoriesTableView.count // \\
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CDTVCell
        
      // let objectInTableView = categoriesTableView[indexPath.row]//\\
         let itemInTableView = menuStuff[indexPath.row]
        
        
                if let menuImage = UIImage(data: itemInTableView.image as! Data) {
                    cell.imageForDriverPic.image = menuImage
                }
        
                cell.bestDriverLabel.text = itemInTableView.menuTitle
                cell.raitingDriverLabel.text = itemInTableView.shortDescriptionMenu
        //
//        cell.imageForDriverPic.image = UIImage(named: objectInTableView["image"]!)//\\
//        cell.bestDriverLabel.text = objectInTableView["name"]//\\
//        cell.raitingDriverLabel.text = objectInTableView["subName"]//\\
        
        return cell
    }
    
//    override   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let vcName = identity[indexPath.row]
//        let viewContr = storyboard?.instantiateViewController(withIdentifier: vcName)
//        self.navigationController?.pushViewController(viewContr!, animated: true)
//    }
//    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            menuStuff.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    @IBAction func addDriver(_ sender: Any) {
    
    
  

    
  
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
        // add button is work. we can add some picture into the menu
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picker.dismiss(animated: true, completion: {
                self.createItemMenu(with: image)
            })
        }
        
    }
    
    
    func createItemMenu(with image: UIImage) {
        
        let menuStuff = CustomMenuStuff(context: managedObjectContext!)
        menuStuff.image = NSData(data: UIImageJPEGRepresentation(image, 0.3)!)
        
        
        
        let inputAlert = UIAlertController(title: "New Menu Stuff", message: "Enter A New Menu Title And Briefly Describe It", preferredStyle: .alert)
        inputAlert.addTextField { (textField: UITextField) in
            textField.placeholder = "Menu Title"
        }
        inputAlert.addTextField { (textField: UITextField) in
            textField.placeholder = "Short Description"
        }
        
        inputAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction) in
            
            let menuNameTextField = inputAlert.textFields?.first
            let discriptionNameTextField = inputAlert.textFields?.last
            
            if menuNameTextField?.text != "" && discriptionNameTextField?.text != "" {
                
                menuStuff.menuTitle = menuNameTextField?.text
                menuStuff.shortDescriptionMenu = discriptionNameTextField?.text
                
                do {
                    try self.managedObjectContext!.save()
                    self.loadData()
                    
                } catch {
                    print ("Could Not Save Data \(error.localizedDescription)")
                    
                }
                
                
            }
            
        }))
        
        
        
        
        inputAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(inputAlert, animated: true, completion: nil)
    } //func createItemMenu
    
} // class
