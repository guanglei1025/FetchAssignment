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
        case serverError

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .serverError:
                return "Invalid status code from server"
            }
        }
    }

    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw RecipeAPIServiceError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode
        else {
            throw RecipeAPIServiceError.serverError
        }

        return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
    }
}

