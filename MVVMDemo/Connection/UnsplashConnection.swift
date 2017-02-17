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

import Alamofire
import ObjectMapper
import RxAlamofire
import RxSwift

struct UnsplashConnection {
    
    static let shared = UnsplashConnection()
    
    private var apiKey = ""
    
    private var headers : [String : String] = [:]
    
    private init() {
        apiKey = Bundle.main.infoDictionary?["UnsplashAppID"] as? String ?? ""
        headers = ["Authorization" : "Client-ID \(apiKey)", "Accepted-Version" : "v1"]
    }
    
    func photos(ofPage page : Int) -> Observable<[UnsplashPhoto]> {
        let parameters = ["page" : page, "per_page" : 15]
        return RxAlamofire.requestJSON(.get, "https://api.unsplash.com/photos", parameters: parameters, headers: headers)
               .map { response, json -> [UnsplashPhoto] in
                    if let json = json as? [[String : Any]] {
                        let mapper = Mapper<UnsplashPhoto>()
                        let photosList = json.map { mapper.map(JSON: $0) }
                        let unwrappedPhotos = photosList.flatMap { $0 }
                        return unwrappedPhotos
                    }
                    return []
            }
    }
    
    
}
