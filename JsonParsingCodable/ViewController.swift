//
//  ViewController.swift
//  JsonParsingCodable
//
//  Created by SARA Technologies  on 10/06/20.
//  Copyright © 2020 SARA Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

struct Company:Codable {
    let name: String
}

struct Geo:Codable {
    let latitude: String
    let longitude:String
    
    enum CodingKeys:String,CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

struct Address:Codable {
    let street: String
    let city: String
    let geoLocation: Geo
    
    enum CodingKeys:String,CodingKey {
        case street
        case city
        case geoLocation = "geo"
    }
}

struct User:Codable { // or Decodable
    let name: String
    let email:String
    let address: Address
    let company: Company
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsing()
    }
    
    private func jsonParsing() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        else{
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil{
                print("error in json parsing")
            }
            
            if let data = data {
                do {
                   let res = try JSONDecoder().decode([User].self, from: data)
                   print(res)
                } catch let error {
                   print(error)
                }
            }
        }.resume()
    }
}

