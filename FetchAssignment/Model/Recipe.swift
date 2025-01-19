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
    let smallIconURL: String

    var iconURL: URL? {
        URL(string: smallIconURL)
    }

    enum CodingKeys: String, CodingKey {
        case name
        case cuisine
        case smallIconURL = "photo_url_small"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name + cuisine)
    }

    init(name: String, cuisine: String, smallIconURL: String) {
        self.name = name
        self.cuisine = cuisine
        self.smallIconURL = smallIconURL
    }
}

extension Recipe {
    static func Mock() -> Recipe {
        Recipe(
            name: "Name",
            cuisine: "Cuisine",
            smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"
        )
    }
}
