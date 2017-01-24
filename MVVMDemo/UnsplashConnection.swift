//
//  UnsplashConnection.swift
//  MVVMDemo
//
//  Created by André Gimenez Faria on 24/01/17.
//  Copyright © 2017 Ginga One. All rights reserved.
//

import Alamofire
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
    
    func photos() -> Observable<String> {
        return RxAlamofire.requestJSON(.get, "https://api.unsplash.com/photos", parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .map { response, json -> String in
                "Teste"
            }
    }
    
    
}
