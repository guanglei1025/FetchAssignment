//
//  RecipeListViewModel.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import Foundation
import Observation

@Observable
class RecipeListViewModel {

    private(set) var groupedRecipes = [String: [Recipe]]()

    private var dataManager: RecipeDataManaging

    init(dataManager: RecipeDataManaging = RecipeDataManager()) {
        self.dataManager = dataManager
    }

    func getRecipes() async throws {
        let recipes = try await dataManager.fetchRecipes()
        await MainActor.run {
            groupedRecipes = groupRecipesByCuisine(recipes)
        }
    }

    func groupRecipesByCuisine(_ recipes: [Recipe]) -> [String: [Recipe]] {
        Dictionary(grouping: recipes, by: { $0.cuisine })
    }
}
