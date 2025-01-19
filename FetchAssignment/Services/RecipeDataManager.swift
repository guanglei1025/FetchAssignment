//
//  RecipeDataManager.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import Foundation

protocol RecipeDataManaging {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeDataManager: RecipeDataManaging {

    private var apiService: RecipeAPIFetching

    init(apiService: RecipeAPIFetching = RecipeAPIService()) {
        self.apiService = apiService
    }

    func fetchRecipes() async throws -> [Recipe] {
        let recipes = try await apiService.fetchRecipes()
        return recipes
    }
}
