//
//  Recipe.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
    let name: String
    let cuisine: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name + cuisine)
    }

    init(name: String, cuisine: String) {
        self.name = name
        self.cuisine = cuisine
    }
}
