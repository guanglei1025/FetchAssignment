//
//  RecipeListViewModel.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import Foundation
import Observation

/// UI layer: Include business logic and update UI

@Observable
class RecipeListViewModel {

    private(set) var groupedRecipes = [String: [Recipe]]()

    private let dataManager: RecipeDataManaging

    /// Avoid making multiple calls
    private var isFetching = false

    init(dataManager: RecipeDataManaging = RecipeDataManager()) {
        self.dataManager = dataManager
    }

    func getRecipes() async throws {
        guard isFetching == false else {
            return
        }
        isFetching = true
        defer { isFetching = false }

        let recipes = try await dataManager.fetchRecipes()
        await MainActor.run {
            groupedRecipes = groupRecipesByCuisine(recipes)
        }
    }

    func groupRecipesByCuisine(_ recipes: [Recipe]) -> [String: [Recipe]] {
        Dictionary(grouping: recipes, by: { $0.cuisine })
    }
}
