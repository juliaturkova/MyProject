//
//  VC.swift
//  My Uber App ForRider
//
//  Created by julia on 21.08.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit

class VC: UIViewController {
    
    private let RIDER_SEGUE = "RiderVC"
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        
        
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            AuthProvider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                if message != nil {
                    self.alertTheUser(title: "Problem With Authentication", message: message!)
                    
                }else {
                    UberHandler.Instance.rider = self.emailTextField.text!
                    
                    self.emailTextField.text! = "" //
                    self.passwordTextField.text! = ""//когда логинимся и делаем логаут, то пароль и логин остаются, а этот метод их удаляет мы видим пустые строки
                    
                    self.performSegue(withIdentifier: self.RIDER_SEGUE, sender: nil)
                }
            })
        } else {
            alertTheUser(title: "Email And Password Are Required", message: "Please Enter Email And Password In The Text Fields")
        }
    }
    

    @IBAction func signUp(_ sender: Any) {
   if emailTextField.text != "" && passwordTextField.text != "" {
    
    AuthProvider.Instance.signUp(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
        if message != nil {
            self.alertTheUser(title: "Problem With Creating A new User", message: message!)
        } else {
            
            UberHandler.Instance.rider = self.emailTextField.text!
            
            self.emailTextField.text! = "" //
            self.passwordTextField.text! = ""//когда логинимся и делаем логаут, то пароль и логин остаются, а этот метод их удаляет мы видим пустые строки
            
           self.performSegue(withIdentifier: self.RIDER_SEGUE, sender: nil)
            
        }
    })
    
   } else {
    alertTheUser(title: "Email And Password Are Required", message: "Please Enter Email And Password In The Text Fields")
    
        }
    
    }
    private func alertTheUser(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    
    }
    
    } //class
