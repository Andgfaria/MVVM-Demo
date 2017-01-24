//
//  UnsplashPhoto.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import ObjectMapper

struct UnsplashPhoto : Mappable {
    
    var created_at = ""
    
    var id = ""
    
    var regularSizeURL = ""
    
    var fullSizeURL = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        created_at <- map["created_at"]
        id <- map["id"]
        regularSizeURL <- map["urls"]["regular"]
        fullSizeURL <- map["urls"]["full"]
    }
    
}
