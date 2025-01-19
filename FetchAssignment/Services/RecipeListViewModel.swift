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

    private(set) var recipes = [Recipe]()

    private var dataManager: RecipeDataManaging

    init(dataManager: RecipeDataManaging = RecipeDataManager()) {
        self.dataManager = dataManager
    }

    func fetchRecipes() async throws {
        recipes = try await dataManager.fetchRecipes()
    }
}
