/*
 The MIT License (MIT)
 
 Copyright (c) 2017 André Gimenez Faria
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

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
