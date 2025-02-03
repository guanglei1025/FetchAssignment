//
//  RecipeDataManager.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import Foundation

/// Repository layer: Handle fetching data from different data source. (e.g. SwiftData, FileManager, Server)
/// Pass `ModelContext` from init if want to implement SwiftData

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
