//
//  Hero.swift
//  SuperHeroApp
//
//  Created by user247205 on 11/9/23.
//

import Foundation

protocol HeroServiceProtocol {
    func getAll(name: String, completion: @escaping (_ success: Bool, _ results: Heros?, _ error: String?) -> Void)
}

class HeroService: HeroServiceProtocol {
    private var url = "https://www.superheroapi.com/api.php/10157703717092094/search/"

    func getAll(name: String, completion: @escaping (Bool, Heros?, String?) -> Void) {
        url += name
        HttpRequestHelper().GET(url: url) { success, data in
            if success {
                do {
                    let heroWrapper = try JSONDecoder().decode(HeroWrapper.self, from: data!)
                    let heros = heroWrapper.heros
                    completion(true, heros, nil)
                    
                } catch {
                    completion(false, nil, "Error: invalid JSON data")
                }
            } else {
                completion(false, nil, "Error: Heros GET request failed")
            }
            
        }
    }
}
