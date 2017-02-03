//
//  UnsplashUser.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 03/02/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import ObjectMapper

struct UnsplashUser : Mappable {
    
    var name = ""
    
    var profilePictureURL = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        profilePictureURL <- map["profileImage_medium"]
    }
    
}
