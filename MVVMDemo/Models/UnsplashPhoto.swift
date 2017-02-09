//
//  UnsplashPhoto.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import ObjectMapper

struct UnsplashPhoto : Mappable {
    
    var colorString = "#000000"
    
    var created_at : Date?
    
    var id = ""
    
    var height = 0.0
    
    var fullSizeURL = ""
    
    var city : String?
    
    var regularSizeURL = ""
    
    var smallSizeURL = ""
    
    var user : UnsplashUser?
    
    var width = 0.0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        colorString <- map["color"]
        created_at <- (map["created_at"],ISO8601DateTransform())
        id <- map["id"]
        height <- map["height"]
        fullSizeURL <- map["urls.full"]
        city <- map["location.city"]
        regularSizeURL <- map["urls.regular"]
        smallSizeURL <- map["urls.small"]
        user <- map["user"]
        width <- map["width"]
    }
    
    
}
