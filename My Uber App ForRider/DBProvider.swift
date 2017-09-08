//
//  DBProvider.swift
//  My Uber App ForRider
//
//  Created by julia on 24.08.17.
//  Copyright © 2017 julia. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider {


private static let _instance = DBProvider()
    static var Instance: DBProvider{
    return _instance
    }

    
    var dbReference: DatabaseReference {
        return Database.database().reference()
        
    }
    
    var ridersReferance: DatabaseReference {
        return dbReference.child(Constans.RIDERS)// возвращает из firebase -> databese
    }
    
    // request referance
    
    var requesetAcceptedReference: DatabaseReference {
        
        return dbReference.child(Constans.UBER_ACCEPTED) // we know what det accpted uber
        
    }
    var requestReference:DatabaseReference {
        
        return dbReference.child(Constans.UBER_REQUEST) // возвращает и лает нам этот чайлд изи датабазы
        
    }
    
    
    
    
    
    // request accepted
    
    func saveUser(withID: String, email: String, password: String) {
        
        let data: Dictionary<String, Any> = [Constans.EMAIL: email, Constans.PASSWORD: password, Constans.isRIDER: true]
        
        ridersReferance.child(withID).child(Constans.DATA).setValue(data)
    }
    
} // class
