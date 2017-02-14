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

import Foundation
import RxSwift

class PhotoAdditionalInfoViewModel {
    
    //MARK: - Instance Variables
    
    static private let dateFormatter = DateFormatter()
    
    var infoTexts = Variable<[(String,String)]>([])

    //MARK: - Setup
    
    required init(photo : UnsplashPhoto) {
        setupInfoTexts(with: photo)
    }
    
    private func setupInfoTexts(with photo : UnsplashPhoto) {
        var texts = [(String,String)]()
        if let city = photo.city {
            texts.append(("City",city))
        }
        if let date = photo.created_at {
            PhotoAdditionalInfoViewModel.dateFormatter.dateStyle = .short
            texts.append(("Date",PhotoAdditionalInfoViewModel.dateFormatter.string(from: date)))
        }
        texts.append(("Size","\(photo.width) x \(photo.height)"))
        infoTexts.value = texts
    }
    
}
