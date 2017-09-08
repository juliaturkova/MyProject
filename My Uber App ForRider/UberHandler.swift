//
//  UberHandler.swift
//  My Uber App ForRider
//
//  Created by julia on 25.08.17.
//  Copyright © 2017 julia. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol UberController: class {
    
    func canCallUber(delegateCalled: Bool)
    func driverAcceptedRequest(requestAccepted: Bool, driverName: String)
    func updateDriversLocation (lat: Double, long: Double)
    
}

class UberHandler {
   
    private static let _instance = UberHandler()
    
    weak var delegate: UberController?
    
    var rider = ""
    var driver = ""
    var riderID = ""
    
    
    static var Instance: UberHandler {
        
    return _instance
    }
    
    func observeMessageForRider (){
        // ruder requested uber
        DBProvider.Instance.requestReference.observe(DataEventType.childAdded) { (snapshot: DataSnapshot) in
            if let data = snapshot .value as? NSDictionary {
                
                if let name = data[Constans.NAME] as? String {
                    
                    if name == self.rider {
                        
                        self.riderID = snapshot.key
                        self.delegate?.canCallUber(delegateCalled: true)
                        //print("The Value Is \(self.riderID)")
                        
                    }
                    
                }
                
            }
        }
        //rider canceled uber
        
        DBProvider.Instance.requestReference.observe(DataEventType.childRemoved) { (snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                
                if let name = data[Constans.NAME] as? String {
                    
                    if name == self.rider {
                        
                        self.delegate?.canCallUber(delegateCalled: false)
                        //print("The Value Is \(self.riderID)")
                        
                    }
                    
                }
                
            }
        }
        // driver accepted uber
        
        DBProvider.Instance.requesetAcceptedReference.observe(DataEventType.childAdded) { (snapshot: DataSnapshot) in
            if let data = snapshot.value as? NSDictionary {
                
                if let name = data[Constans.NAME] as? String { //that mean that we have a driver
                    
                    if self.driver == "" {
                        self.driver = name
                        self.delegate?.driverAcceptedRequest(requestAccepted: true, driverName: self.driver) // we inform our user that the driver has accepted his request (using delegate)
                        
                        
                        
                    }// wait when the driver has accepted the uber and the child will be added into requesetAcceptedReference
                    
                }
                
                
                
            }
        }
        //DRIVER CANCELED UBER
        DBProvider.Instance.requesetAcceptedReference.observe(DataEventType.childRemoved) { (snapshot: DataSnapshot) in //childRemoved we actually know that childRemoved that mean what driver caceled the uber and child has been removed from database 
            
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constans.NAME] as? String {
                    if name == self.driver  { // we have driver name when he accepted uber(look up)
                        self.driver = ""
                        self.delegate?.driverAcceptedRequest(requestAccepted: false, driverName: name)
                    }
                }
            }

        }
        // DRIVER UPDATING LOCATION 
        DBProvider.Instance.requesetAcceptedReference.observe(DataEventType.childChanged) { (snapshot: DataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                
                if let name = data[Constans.NAME] as? String {
                    
                    if name == self.driver {
                        
                        if let lat = data[Constans.LATITUDE] as? Double{
                            if let long = data[Constans.LONGITUDE] as? Double {
                                self.delegate?.updateDriversLocation(lat: lat, long: long)
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    func requestUber(latitude: Double, longitude: Double) {
        
        let data: Dictionary<String, Any> = [Constans.NAME: rider, Constans.LATITUDE: latitude, Constans.LONGITUDE: longitude]
        
        DBProvider.Instance.requestReference.childByAutoId().setValue(data) //request uber i can see it database
    } //request uber
    
    func cancelUber (){
        
        DBProvider.Instance.requestReference.child(riderID).removeValue()
        
    }
    
    func updateRiderLocation(lat: Double, long: Double) {
        
        DBProvider.Instance.requestReference.child(riderID).updateChildValues([Constans.LATITUDE: lat, Constans.LONGITUDE: long])// watch func requestUber (we have rideraiD, latitude, longitude
        
    }
    
}// class 

