//
//  Model.swift
//  testTask
//
//  Created by BigSynt on 22.01.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import Foundation

// MARK: - Drug
struct Drug: Codable {
    let id: Int?
    let image: String?
    let categories: Categories?
    var name, description: String?
    var documentation: String?
    let fields: [Field]?
}

// MARK: - Categories
struct Categories: Codable {
    let id: Int?
    let icon, image, name: String?
}

// MARK: - Field
struct Field: Codable {
    let typesID: Int?
    let type, name, value, image: String?
    let flags: Flags?
    let show, group: Int?
    
    enum CodingKeys: String, CodingKey {
        case typesID = "types_id"
        case type, name, value, image, flags, show, group
    }
}

// MARK: - Flags
struct Flags: Codable {
    let html, noValue, noName, noImage: Int?
    let noWrap, noWrapName, system: Int?

    enum CodingKeys: String, CodingKey {
        case html
        case noValue = "no_value"
        case noName = "no_name"
        case noImage = "no_image"
        case noWrap = "no_wrap"
        case noWrapName = "no_wrap_name"
        case system
    }
}

//enum TypeEnum: String, Codable {
//    case image = "image"
//    case list = "list"
//    case text = "text"
//}

typealias Drugs = [Drug]

struct DrugEntity: Hashable {

    let id: Int
    let image: String
    var name: String
    var description: String
    
    var wideDescription: String
    
    //var categories: Categories
    var categories: CategoriesHashble
//    var categories: CategoriesHashble
    
}

struct CategoriesHashble: Hashable {
    var id: Int
    var icon, image, name: String
}

extension DrugEntity {
    init(data: Drug) {
        self.id = data.id ?? 0
        self.image = data.image ?? ""
        self.name = data.name ?? ""
        self.description = data.description ?? ""
        
        self.wideDescription = data.description ?? ""
        
        self.categories = .init(id: 0, icon: "", image: "", name: "")
        
        self.categories.id = data.categories?.id ?? 0
        self.categories.icon = data.categories?.icon ?? ""
        self.categories.image = data.categories?.image ?? ""
        self.categories.name = data.categories?.name ?? ""
    }
}

//extension CategoriesHashble {
//    init(data: Drug) {
//        //self = data.categories
//        self.id = data.categories?.id ?? 0
//        self.icon = data.categories?.icon ?? ""
//        self.image = data.categories?.image ?? ""
//        self.name = data.categories?.name ?? ""
//    }
//}
