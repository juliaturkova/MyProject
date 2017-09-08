//
//  tryVC.swift
//  My Uber App ForRider
//
//  Created by julia on 08.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class tryVC: UIViewController {
    
    
  
    @IBOutlet weak var myImage: UIImageView!
    
    @IBAction func btnPressed1(_ sender: Any) {
        updateImage(button: 1)
    }

    
    @IBAction func btnPressed2(_ sender: Any) {
        updateImage(button: 2)
    }
    
    
    @IBAction func btnPressed3(_ sender: Any) {
        updateImage(button: 3)
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    
    
    func updateImage(button: Int) {
        self.activityIndicator.startAnimating()
        
        var imageURL = URL(string: "")
        switch button {
            
        case 1:
            
            imageURL = URL(string: "https://s-media-cache-ak0.pinimg.com/originals/83/65/c4/8365c440f9447b069aa9bd8097dba3a8.jpg")
        case 2:
            
            imageURL = URL(string: "https://i.pinimg.com/736x/f7/7e/06/f77e067fbf6b8e2420a3e57f7fb07a3c--space-iphone-wallpaper-iphone-backgrounds.jpg")
        case 3:
            
            imageURL = URL(string: "https://i.pinimg.com/736x/72/33/64/723364c3e0f33bac03c3952d041a289c.jpg")
            
        default: break
        }
        
        
        
        //async 
        
        DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async{
        
        
        let fetch = NSData(contentsOf: imageURL! as URL)
            DispatchQueue.main.async {
              
        if let imageData = fetch {
            self.activityIndicator.stopAnimating()
            self.myImage.image = UIImage(data: imageData as Data)
                }
        }
            }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.stopAnimating()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
