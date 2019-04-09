//
//  Storage.swift
//  Assignment2
//
//  Created by Min young Go on 9/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import Foundation

class Storage {
    static let shared: Storage = Storage()
    
    var objects: [Location]
    
    private init(){
        objects = [Location]()
    }
    
}
