//
//  UnsplashConnection.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import Alamofire
import ObjectMapper
import RxAlamofire
import RxSwift

struct UnsplashConnection {
    
    static let shared = UnsplashConnection()
    
    private var apiKey = ""
    
    private var headers : [String : String] = [:]
    
    private init() {
        apiKey = ProcessInfo.processInfo.environment["UNSPLASH_API_ID"] ?? ""
        headers = ["Authorization" : "Client-ID \(apiKey)", "Accepted-Version" : "v1"]
    }
    
    func photos(ofPage page : Int) -> Observable<[UnsplashPhoto]> {
        let parameters = ["page" : page, "per_page" : 15]
        return RxAlamofire.requestJSON(.get, "https://api.unsplash.com/photos", parameters: parameters, headers: headers)
               .map { response, json -> [UnsplashPhoto] in
                    if let json = json as? [[String : Any]] {
                        let mapper = Mapper<UnsplashPhoto>()
                        let photosList = json.map { mapper.map(JSON: $0) }
                        let unwrappedPhotos = photosList.filter { $0 != nil }.map { $0! }
                    return unwrappedPhotos
                    }
                    return []
            }
    }
    
    
}
