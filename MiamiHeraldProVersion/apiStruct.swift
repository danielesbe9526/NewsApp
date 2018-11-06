//
//  apiStruct.swift
//  MiamiHeraldProVersion
//
//  Created by Daniel Beltran on 9/25/18.
//  Copyright © 2018 Daniel Beltran. All rights reserved.
//

import UIKit

struct source : Decodable {
    let id : String?
    let name : String?
}
struct jsonInfo : Decodable {
    let source : source?
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?

    
//    init(source:source ,author : String, title:String,description:String,url:String,urlToImage:String,publishedAt:String,content:String) {
//        self.source = source
//        self.author = author
//        self.title = title
//        self.description = description
//        self.url = url
//        self.urlToImage = urlToImage
//        self.publishedAt = publishedAt
//        self.content = content
//    }
}

class apiStruct: NSObject {
    
    
    var currentNews =  [jsonInfo]()
    var titles = [String]()
    var images = [String]()
    var dates = [String]()
    
//    var newsIMages = [UIImage]()
    var country = "co"
    
    func getApi (completeDownloadApi: @escaping (Bool) -> Void) {
        var code = Int()
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(self.country)&apiKey=5795d62c510e490e863d040c16eccaf4")
            else {
//                print("dont can get the information")
                return}
        
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                
                if let httpCode =  response as? HTTPURLResponse{
                    code = httpCode.statusCode
                }
            
                
                if code <= 206 {
                    if let data = data {
                        do {
                            self.currentNews.removeAll()
                            self.titles.removeAll()
                            self.images.removeAll()
                            self.dates.removeAll()
                            
//                               guard (try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]) != nil else { return }
                            let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                            guard let news = dataDictionary??["articles"] as? [[String: Any]] else {return}
                            
                            for newsDictionary in news {
                                
                                let currentNew = jsonInfo(  source: newsDictionary["source"] as? source ,
                                                          author: newsDictionary["author"] as? String,
                                                          title: newsDictionary["title"] as? String,
                                                          description: newsDictionary["description"] as? String,
                                                          url: newsDictionary["url"] as? String ,
                                                          urlToImage: newsDictionary["urlToImage"] as? String,
                                                          publishedAt: newsDictionary["publishedAt"] as? String,
                                                          content: newsDictionary["content"] as?String)
                                
                                if let titleString = currentNew.title {
                                    self.titles.append(titleString)
                                } else {
                                    self.titles.append("titleString")
                                }
                                if let imageString = currentNew.urlToImage{
                                    self.images.append(imageString)
                                } else {
                                    self.images.append("imageString")
                                }
                                if let dateString = currentNew.publishedAt{
                                    self.dates.append(dateString)
                                } else {
                                    self.dates.append("Date Nill")
                                }
                                
                                
                                
//                                let sorceNew = source(id: newsDictionary["source"]!["id"], name: newsDictionary["source"]["name"])
//                                var  soruceNew = try JSONDecoder().decode(source, from: currentNew)
                                
//                                let new = try JSONDecoder().decode(jsonInfo, from: newsDictionary)
//                                self.names.append(namesNews["name"])
                                self.currentNews.append(currentNew)
                            }
//                                completionHandler(self.currentNews)
                            completeDownloadApi(true)
//                                print(self.currentNews)
                            
//                            print(dataDictionary!!["articles"])
//                            let news = try JSONDecoder().decode(jsonInfo.self, from: dataDictionary??["articles"])
//                            print(news)
//                            guard let arrayArticles = dataDictionary??["articles"] as? [jsonInfo]
//                                else {
//                                return
//                            }
//                            print(arrayArticles)
                            
                            
                        }
//                        catch{
//                            print(error)
//                        }
                    }
                    
                }   else if code > 206 && code < 400 {
                    print("You have been redirectionated")
                    completeDownloadApi(false)
                }
                else if code >= 400{
                    
                    print("You have clien side errors ")
                    

                    if code == 404 {
                        print("Not found")
                        
                    }
                    completeDownloadApi(false)
                }
            }.resume()
    }
    

    
    
}
