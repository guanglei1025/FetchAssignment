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

struct Recipe: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let cuisine: String
    let smallIconURL: String

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case smallIconURL = "photo_url_small"
    }

    init(id: String, name: String, cuisine: String, smallIconURL: String) {
        self.id = id
        self.name = name
        self.cuisine = cuisine
        self.smallIconURL = smallIconURL
    }
}

extension Recipe {
    static func mockData() -> Recipe {
        Recipe(
            id: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
            name: "Name",
            cuisine: "Cuisine",
            smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"
        )
    }
}
