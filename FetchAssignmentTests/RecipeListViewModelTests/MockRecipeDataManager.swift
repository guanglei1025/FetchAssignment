//
//  MockRecipeDataManager.swift
//  FetchAssignmentTests
//
//  Created by Guanglei Liu on 1/19/25.
//

import Foundation
@testable import FetchAssignment

enum MockRecipeDataManagerError: Error {
    case stubResponseNotSet
    case mockResponseError
}

class MockRecipeDataManager: RecipeDataManaging {

    var stubResponse: Result<[Recipe], Error>?

    init() {}

    func fetchRecipes() async throws -> [Recipe] {
        switch stubResponse {
        case .success(let recipes):
            return recipes
        case .failure(let error):
            throw error
        case .none:
            throw MockRecipeDataManagerError.stubResponseNotSet
        }
    }
}
