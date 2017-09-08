//
//  SecondAnimationVC.swift
//  My Uber App ForRider
//
//  Created by julia on 05.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class SecondAnimationVC: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exitButton.layer.cornerRadius = exitButton.frame.size.width / 2
        
        // Do any additional setup after loading the view.
    }
    

    
    
    
    
    @IBAction func exitButton2(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
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
