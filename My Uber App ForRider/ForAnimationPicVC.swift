//
//  ForAnimationPicVC.swift
//  My Uber App ForRider
//
//  Created by julia on 06.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class ForAnimationPicVC: UIViewController {
    
//    
//    @IBOutlet weak var imageBG: UIImageView!
//    
//    @IBOutlet weak var yourLabel: UILabel!
//    
//    @IBOutlet weak var positionLabel: UILabel!
//    
//    @IBOutlet weak var inTheRatingLabel: UILabel!
//    
//    @IBOutlet weak var goButton: UIButton!
//    
//    @IBOutlet weak var findMeLabel: UILabel!
//    
    
    
    @IBOutlet weak var imageBG: UIImageView!
    
    
    @IBOutlet weak var yourLabel: UILabel!
    
    
    @IBOutlet weak var positionLabel: UILabel!
   
    
    @IBOutlet weak var inTheRatingLabel: UILabel!
    
    
    @IBOutlet weak var goButton: UIButton!

        override func viewDidLoad() {
        super.viewDidLoad()
        
        imageBG.alpha = 0
        
        yourLabel.alpha = 0
        
        positionLabel.alpha = 0
        
        inTheRatingLabel.alpha = 0
        
        goButton.alpha = 0
            
            // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.imageBG.alpha = 0.8
        }) { (true) in
            
            self.showYour()
            
        }
    }
    func showYour(){
        
        UIView.animate(withDuration: 1, animations: {
           self.yourLabel.alpha = 1
        }) { (true) in
          
            self.showPositionLabel()
            
        }
        
    }
    
    func showPositionLabel(){
        UIView.animate(withDuration: 1, animations: {
            self.positionLabel.alpha = 1
        }) { (true) in
            self.showInTheRatingLabel ()
        }
        
        
    }
 
    func showInTheRatingLabel () {
        UIView.animate(withDuration: 1, animations: {
            self.inTheRatingLabel.alpha = 1
        }) { (true) in
            self.showGoButton()
        }
        
    }
    
    func showGoButton() {
        
        UIView.animate(withDuration: 1) { 
            self.goButton.alpha = 1
            
        }
        
    }
    
    
}
