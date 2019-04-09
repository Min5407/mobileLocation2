
//
//  File.swift
//  Assignment2
//
//  Created by Min young Go on 9/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import Foundation


class Location{
    var name:String
    var address: String
    var long: String
    var lat: String
    
    init(name:String, address:String, long:Double, lat:Double) {
        self.name = name
        self.address = address
        self.long = "\(long)"
        self.lat = "\(lat)"
    }
}
