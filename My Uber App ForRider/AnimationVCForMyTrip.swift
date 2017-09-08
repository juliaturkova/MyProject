//
//  AnimationVCForMyTrip.swift
//  My Uber App ForRider
//
//  Created by julia on 05.09.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class AnimationVCForMyTrip: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var uberButton: UIButton!
    
    let transition =  AnimationTransitionVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uberButton.layer.cornerRadius = uberButton.frame.size.width / 2 
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let secondVC = segue.destination as! SecondAnimationVC
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = uberButton.center
        transition.circleColor = uberButton.backgroundColor!
        return transition
    }
    
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = uberButton.center
        transition.circleColor = uberButton.backgroundColor!
        return transition
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
