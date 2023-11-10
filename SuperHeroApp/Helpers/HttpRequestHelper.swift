//
//  Hero.swift
//  SuperHeroApp
//
//  Created by user247205 on 11/9/23.
//

import Foundation

class HttpRequestHelper {
    func GET(url: String, completion: @escaping (Bool, Data?) -> Void ) {
        
        guard let url = URL(string: url) else {
            completion(false, nil)
            return
        }
       
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest ) { data, response, error in
            guard error ==  nil else {
                print("Error: problem calling GET")
                print(error!)
                completion(false, nil)
                return
            }
            
            guard let data = data else {
                print("Error: did not receive data")
                completion(false, nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error: HTTP request failed")
                completion(false, nil)
                return
            }
            
            completion(true,data)
        }.resume()
        
    }
}
