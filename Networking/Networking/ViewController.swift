//
//  ViewController.swift
//  Networking
//
//  Created by iMac_VTCA on 12/18/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

//enum CodingKeys available when implement Codable

import UIKit

let API_URL = "http://omdbapi.com/?apikey=7882463&s=batman"

struct Movie: Codable {
    var title: String
    var year: String
    var imdbID: String
    var `Type`: String
    var poster: String
    
    //    init(with dict: [String : Any]) {
    //
    //        self.title = dict["Title"] as? String ?? ""
    //        self.year = dict["Year"] as? String ?? ""
    //        self.imdbID = dict["imdbID"] as? String ?? ""
    //        self.type = dict["Type"] as? String ?? ""
    //        self.poster = dict["Poster"] as? String ?? ""
    //    }
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID, `Type`
        case poster = "Poster"
    }
    
}

struct Search: Codable {
    var search: [Movie]
//    var totalResults: String
//    var Response: String
    
    private enum CodingKeys : String, CodingKey {
        case search = "Search"
    }
}

class ViewController: UIViewController {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    var arrayMovie = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAPI()
    }
    
    private func requestAPI() {
        //1
        dataTask?.cancel()
        
        //2
        if var urlComponent = URLComponents(string: "http://omdbapi.com/") {
            urlComponent.query = "apikey=7882463&s=batman"
            
            //3
            guard let url = urlComponent.url else { return }
            
            //4
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //5
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    do {
                        //                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        //
                        //                        if let dictionary = jsonObject as? [String : Any] {
                        //
                        //                            if let arraySearchDict = dictionary["Search"] as? [[String : Any]] {
                        //
                        //                                for dict in arraySearchDict {
                        //
                        //                                    let model = Movie(with: dict)
                        //                                    self.arrayMovie.append(model)
                        //                                }
                        //                            }
                        //                            print(self.arrayMovie.first ?? "")
                        //                        }
                        
                        let jsonDecoder = JSONDecoder()
                        let movie = try jsonDecoder.decode(Search.self, from: data)
                        print(movie)
                        
                        
                    } catch {
                        print("Error: \(error)")
                    }
                    
                    print("Success")
                }
            })
            
            dataTask?.resume()
        }
    }
    
}

