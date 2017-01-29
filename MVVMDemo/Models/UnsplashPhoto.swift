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
    
    var created_at = ""
    
    var id = ""
    
    var height = 0.0
    
    var fullSizeURL = ""
    
    var regularSizeURL = ""
    
    var smallSizeURL = ""
    
    var width = 0.0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        colorString <- map["color"]
        created_at <- map["created_at"]
        id <- map["id"]
        height <- map["height"]
        fullSizeURL <- map["urls.full"]
        regularSizeURL <- map["urls.regular"]
        smallSizeURL <- map["urls.small"]
        width <- map["width"]
    }
    
}
