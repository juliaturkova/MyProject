//
//  GestureVCForPhoto.swift
//  My Uber App ForRider
//
//  Created by julia on 05.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class GestureVCForPhoto: UIViewController {

    
    var uberImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uberImage = UIImageView()
        self.uberImage.image = #imageLiteral(resourceName: "uber")
        self.uberImage.isUserInteractionEnabled = true
        self.uberImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(uberImage)

        // Do any additional setup after loading the view.
        
        //add Constraint
        let widthConstraints = NSLayoutConstraint(item: self.uberImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        
        let heightConstraint =  NSLayoutConstraint(item: self.uberImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
  
    let xConstraint = NSLayoutConstraint(item: self.uberImage, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0)
        
        let yConstraint = NSLayoutConstraint(item: self.uberImage, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([widthConstraints, heightConstraint, xConstraint, yConstraint])
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(GestureVCForPhoto.rotate(gesture:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(GestureVCForPhoto.pan(gesture:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(GestureVCForPhoto.pinch(gesture:)))
        
        let gestures: [UIGestureRecognizer] = [rotateGesture, panGesture, pinchGesture]
        
        for gesture in gestures {
            
            self.uberImage.addGestureRecognizer(gesture)
        }
        
    }
    
    func rotate (gesture: UIRotationGestureRecognizer) {
        
        if let gestureView = gesture.view {
            
            gestureView.transform = CGAffineTransform.init(rotationAngle: gesture.rotation)
        }
        
    }
    
    func pan (gesture:UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        
        if let gestureView = gesture.view {
            
            gestureView.center = CGPoint(x: gestureView.center.x + translation.x, y: gestureView.center.y + translation.y)
            
        }
        
        gesture.setTranslation(CGPoint.zero, in: self.view)
        
    }
    
    func pinch (gesture:UIPinchGestureRecognizer){
        
        if let gestureView = gesture.view {
            
            gestureView.transform = CGAffineTransform.init(scaleX: gesture.scale, y: gesture.scale)
        }
        
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
