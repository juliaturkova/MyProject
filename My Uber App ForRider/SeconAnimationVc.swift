//
//  AsyncVC.swift
//  My Uber App ForRider
//
//  Created by julia on 08.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class AsyncVC: UIViewController {
    
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var darkRoundView: UIView!
    
    @IBOutlet weak var toggleMenuButton: UIButton!
    
  
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var faceBookButton: UIButton!

    @IBOutlet weak var mailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        darkRoundView.layer.cornerRadius = darkRoundView.frame.size.width / 2
        twitterButton.alpha = 0
        faceBookButton.alpha = 0
        mailButton.alpha = 0
        
    }

    @IBAction func toggleMenu(_ sender: Any) {
        
        if darkRoundView.transform == CGAffineTransform.identity {
        UIView.animate(withDuration: 1, animations: {
            self.darkRoundView.transform = CGAffineTransform(scaleX: 11, y: 11)
            self.menuView.transform = CGAffineTransform(translationX: 0, y: -68)
            self.toggleMenuButton.transform = CGAffineTransform(rotationAngle: self.radians(180))
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.toggleSharedButton()
            })
            self.toggleSharedButton()
        
        }
        
        } else {
            
            UIView.animate(withDuration: 1, animations: {
                self.darkRoundView.transform = .identity
                self.menuView.transform = .identity
                self.toggleMenuButton.transform = .identity
                self.toggleSharedButton()
                
                
            })
            
        }
        
    }
    
    func toggleSharedButton() {
        
        let alpha = CGFloat (twitterButton.alpha == 0 ? 1 : 0) // if  alpha  equle 0 than 1 : 0
        twitterButton.alpha = alpha
        faceBookButton.alpha = alpha
        mailButton.alpha = alpha
        
    }
    
    
    
       
    func radians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / degrees)
    }






}
