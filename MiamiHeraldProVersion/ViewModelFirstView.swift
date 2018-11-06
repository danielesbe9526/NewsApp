//
//  ViewModelFirstView.swift
//  MiamiHeraldProVersion
//
//  Created by Daniel Beltran on 9/24/18.
//  Copyright © 2018 Daniel Beltran. All rights reserved.
//

import UIKit

class ViewModelFirstView: NSObject {
    
    let countrys =  ModelFirstView().tittles
    var currentNews = [jsonInfo]()
    var newsTittles = [String]()
    var newsImages = [String]()
    var images = [UIImage]()
    var newsDates = [String]()
    var datesFormatted = [Date]()
    var lapsetdate = [String]()

    
    let api = apiStruct()
    
    func loadedData(loaded: @escaping (Bool) -> Void){
        api.getApi { (state) in
            if state{
//                _ =  apiStruct().currentNews
//                print("finish to dowunload")
                loaded(true)
                self.newsTittles = self.api.titles
                self.newsImages = self.api.images
                self.currentNews = self.api.currentNews
                self.newsDates = self.api.dates
                
                
                for  _ in 0...self.newsImages.count-1 {
//                    let emptyImage = UIImage()
                    let emptyImage = UIImage(imageLiteralResourceName: "emptyImage")
                    self.images.append(emptyImage)
                }
                
                let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
//                let calendar = Calendar.current

               
                
                for  position in 0...self.newsDates.count-1 {
//                    let dateFormatter = DateFormatter()
//                    //2018-10-02T13:28:53Z
//                    dateFormatter.dateFormat = "YYYY'-'MM'-'dd'T':'HH':'MM':'SSZZZ"
                    
//                    guard let date = dateFormatter.date(from: self.newsDates[position]) else {
//                        return
//                    }
                    if let aDate = dateFormatter.date(from: self.newsDates[position]) {
//                        let hour = calendar.component(.hour, from: aDate)
//                        let minute = calendar.component(.minute, from: aDate)
//                        let datecomponents = calendar.component(.hour, from: aDate)
                        
    
                        let timeInterval = aDate.timeIntervalSinceNow
                        
                        let dateComponentsFormatter = DateComponentsFormatter()
                        
                        if let dateString = dateComponentsFormatter.string(from: abs(timeInterval)) {
                            
                            
//                            print ("Elapsed time=\(dateString)")
                            self.lapsetdate.append(dateString)
                        }
                    }
                    
                    
//
//
//
                }
                
//
                self.dowloadImages()
//                var names = self.api.currentNew
                
            }
            else {
                loaded(false)
            }
        }
    }
    
    func resizeIMages(image: UIImage, targetSize:CGSize) -> UIImage{
        let size = image.size
        
        let widthRatio = targetSize.width / size.width
        let heighRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heighRatio){
            newSize = CGSize(width: size.width * heighRatio, height: size.height * heighRatio)
        }else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false,1.0 )
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
//    func dowloadImages (imagesLoaded: @escaping (Bool)->Void ) {
        func dowloadImages () {
            
        if self.images.count != 0 {
            
            for position in 0...self.images.count-1  {
                
//            self.images.append(UIImage.init())
//            self.dowloadImages(self.newsImages.count-1)
                
                if self.newsImages[position] != "imageString" {
                    
                    //                 let url = URL(fileURLWithPath: self.newsImages[position])
                    guard let url = URL(string: self.newsImages[position])else {
                        return
                    }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        
                        if (error != nil){
                            print(error as Any)
                        }
                        if data == nil {
                            print("data nil")
                            
                        }
                        if let data = data {
                            guard  let image = UIImage(data: data) else {return}
                            
                            if self.images.count > 0 {
                                let resizedImage = self.resizeIMages(image: image, targetSize: CGSize(width: 414, height: 200))
                                self.images[position] = resizedImage
                            }
                           
                           
//                            imagesLoaded(true)
                        }
                        }.resume()
                    
//                }else {
//                    UIColor(patternImage: #imageLiteral(resourceName: "emptyImage"))
//                            let image = UIImage(data: data)!
//                    let image = UIImage(cgImage: #imageLiteral(resourceName: "emptyImage") )
                    let image = UIImage(imageLiteralResourceName: "emptyImage")
//                            let resizedImage = self.resizeIMages(image: image, targetSize: CGSize(width: 414, height: 200))
//                               image.content
                            self.images[position] = image
//                            imagesLoaded(true)
                }
                
            }

        }

    }
    

    
    
    func changeCountryApi(city : String){
        images.removeAll()
        lapsetdate.removeAll()
        switch city {
        case "Colombia":
            self.api.country = "co"
        case "Usa":
            self.api.country = "us"
        case "Brasil":
            self.api.country = "br"
        case "Australia":
            self.api.country = "au"
        default:
            self.api.country = "co"
        }
    }
    
  
  

    
//    let apiModel = apiStruct().getApi()
//    func reloadData(completionHandler : ([jsonInfo]) -> Void ){
////        let apiModel = apiStruct().getApi()
//        let currentNews = apiStruct ().currentNews
//    }
 }
