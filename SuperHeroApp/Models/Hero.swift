//
//  Hero.swift
//  SuperHeroApp
//
//  Created by user247205 on 11/9/23.
//

import Foundation

typealias Heros = [Hero]

struct Hero: Decodable {
    let name: String
    let biography: Biography
    let image: HeroImage

    enum CodingKeys: String, CodingKey {
        case name
        case biography
        case image
    }
}

struct Biography: Decodable {
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full-name"
    }
}

struct HeroImage: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

struct HeroWrapper: Decodable {
    let heros: Heros
    
    enum CodingKeys: String, CodingKey {
        case heros = "results"
    }
}
