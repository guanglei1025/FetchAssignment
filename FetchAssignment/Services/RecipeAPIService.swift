//
//  RecipeAPIService.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import Foundation

protocol RecipeAPIFetching {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeAPIService: RecipeAPIFetching {

    enum RecipeAPIServiceError: LocalizedError {
        case invalidURL

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            }
        }
    }

    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw RecipeAPIServiceError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
    }
}

