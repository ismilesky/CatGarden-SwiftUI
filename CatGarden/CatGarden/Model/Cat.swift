//
//  Cat.swift
//  CatGarden
//
//  Created by edy on 2023/6/14.
//

import Foundation

import SwiftUI

struct Cat: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let weight: String
    let imageName: String
    let hairType: String
    let description: String
    let bodyType: String
    let origin: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weight
        case imageName
        case hairType
        case description
        case bodyType
        case origin
    }

    init(id: String = UUID().uuidString, name: String, weight: String = "", imageName: String = "", hairType: String = "", description: String = "", bodyType: String = "", origin: String = "") {
        self.id = id
        self.name = name
        self.weight = weight
        self.imageName = imageName
        self.hairType = hairType
        self.description = description
        self.bodyType = bodyType
        self.origin = origin
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        weight = try container.decodeIfPresent(String.self, forKey: .weight) ?? ""
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName) ?? ""
        hairType = try container.decodeIfPresent(String.self, forKey: .hairType) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        bodyType = try container.decodeIfPresent(String.self, forKey: .bodyType) ?? ""
        origin = try container.decodeIfPresent(String.self, forKey: .origin) ?? ""
    }
}


enum HairType: String, Codable, CaseIterable {
    case Short = "短毛"
    case Long = "长毛"
    case None = "无毛"
}

