//
//  RiderVC.swift
//  My Uber App ForRider
//
//  Created by julia on 24.08.17.
//  Copyright © 2017 julia. All rights reserved.
//

import UIKit
import MapKit
class RiderVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UberController {

    
    
    @IBOutlet weak var myMap: MKMapView!
    
    
    @IBOutlet weak var callUberButton: UIButton!
    
    
    private var locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    private var driverLocation: CLLocationCoordinate2D? // we path from rider app
    
    private var timer = Timer()
    
    private var canCallUber = true // can we call uber or not
    private var riderCanceledRequest = false //cancel rider uber request ir not
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        initializeLocationManager()
        UberHandler.Instance.observeMessageForRider()
        UberHandler.Instance.delegate = self
        
        }
        
        private
        func initializeLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // request from the user than he start usibg our app
        locationManager.startUpdatingLocation()
        
        }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) //start update location
    {
        // if we have hthe coordinates from the manager
        if let location = locationManager.location?.coordinate // we shoud have userLocation (privite var)
        {
            
            userLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude) // take from locationManager.location?.coordinate. under this method using our coordinates
            let region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)) // zooming level latitudeDelta: 0.01, longitudeDelta: 0.01
            myMap.setRegion(region, animated: true)
            myMap.removeAnnotations(myMap.annotations) // remove all anootations before we start to have our annotation
            
            if driverLocation != nil {
                if !canCallUber { // we cann't call uber, because we already have uber and he is coming to our location. we can not have 2 ubers in the same time
                    
                    let driverAnnotation = MKPointAnnotation()
                    driverAnnotation.coordinate = driverLocation!
                    driverAnnotation.title = "Driver Location"
                    myMap.addAnnotation(driverAnnotation)
                }
               
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation! // our own location like driver
            annotation.title = "Drivers Location"
            myMap.addAnnotation(annotation)
        }
    }
    
    func updateRidersLocation() {
        
        UberHandler.Instance.updateRiderLocation(lat: userLocation!.latitude, long: userLocation!.longitude) // update by timer
        
    }
    
    func canCallUber(delegateCalled: Bool) {

        if delegateCalled{
            
            callUberButton.setTitle("Cancel Uber", for: UIControlState.normal)
            canCallUber = false // we don't can call the uber un next time, but we cancaled uber
        } else {
            
            callUberButton.setTitle("Call Uber", for: UIControlState.normal)
            canCallUber = true // we actially call uber 
            
        }
        
    }
    
    func driverAcceptedRequest(requestAccepted: Bool, driverName: String) {
        // tell the rider that his ubercar will coming very soon or driver didn't cancel the requset
        
        if !riderCanceledRequest { //if the rider didn't cancel the uber
            
            if requestAccepted {
                alertTheUser(title: "Uber Accepted", message: "\(driverName) Accepted Your Uber Request")
          
            } else {
              // if the request was canceled
                UberHandler.Instance.cancelUber()
                timer.invalidate()
                alertTheUser(title: "Uber Canceled", message: "\(driverName) Canceled Uber Request")
                
            }
            
        }
        
        riderCanceledRequest = false // every time when the driverAcceptedRequest our  riderCanceledRequest = false, because we reset request by riderCanceledRequest  
    }
    
    func updateDriversLocation (lat: Double, long: Double) {
        
      driverLocation = CLLocationCoordinate2D(latitude: lat, longitude: long) // every time driver updates his location we are gonna call delegate. updateDriversLocation because we observing that event when the child has changed and update new location on map
        
    }
    
    @IBAction func callUber(_ sender: Any) {
       // we need to know when cancel uber when call
        
        if userLocation != nil {
            
            if canCallUber {
                
                UberHandler.Instance.requestUber(latitude: Double(userLocation!.latitude), longitude: Double(userLocation!.longitude))
                
                timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(RiderVC.updateRidersLocation), userInfo: nil, repeats: true)
                
                
            } else {
                
                riderCanceledRequest = true
                UberHandler.Instance.cancelUber() // cancel Uber
                timer.invalidate()
            }
            
        }
    
    }

    @IBAction func logOut(_ sender: Any) {
        
        if AuthProvider.Instance.logOut() {
           
            if !canCallUber {
                UberHandler.Instance.cancelUber()
                timer.invalidate()
                
            }
            
            dismiss(animated: true, completion: nil)
            
        } else{
            // problem with loging out
            alertTheUser(title: "Could Not Log Out", message: "We Coulg Not Log Out At The Moment, Please Try Again Later")
        }
    }
            private func alertTheUser(title: String, message: String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
                
            }
            
    
    

} //class 
