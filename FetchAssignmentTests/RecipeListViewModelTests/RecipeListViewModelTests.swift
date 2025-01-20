//
//  RecipeListViewModelTests.swift
//  FetchAssignmentTests
//
//  Created by Guanglei Liu on 1/19/25.
//

import XCTest
@testable import FetchAssignment

final class RecipeListViewModelTests: XCTestCase {

    var sut: RecipeListViewModel!
    var mockRecipeDataManager: MockRecipeDataManager!

    override func setUp()  {
        super.setUp()
        mockRecipeDataManager = MockRecipeDataManager()
    }

    override func tearDown()  {
        sut = nil
        mockRecipeDataManager = nil
        super.tearDown()
    }

    func test_fetchRecipes_givenRecipes_shouldReturnGroupedRecipes() async throws {
        sut = RecipeListViewModel(dataManager: mockRecipeDataManager)

        let mockRecipes: [Recipe] = [
            Recipe(id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                   name: "Apam Balik",
                   cuisine: "British",
                   smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            Recipe(id: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                   name: "Apple & Blackberry Crumble",
                   cuisine: "British",
                   smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")
        ]

        let expectedRecipes: [String: [Recipe]] = [
            "British": mockRecipes
        ]

        mockRecipeDataManager.stubResponse = .success(mockRecipes)

        try await sut.getRecipes()
        XCTAssertEqual(sut.groupedRecipes, expectedRecipes)
    }

    func test_fetchRecipes_givenError_shouldReturnError() async throws {
        sut = RecipeListViewModel(dataManager: mockRecipeDataManager)

        let expectedError = MockRecipeDataManagerError.mockResponseError
        mockRecipeDataManager.stubResponse = .failure(expectedError)

        do {
            try await sut.getRecipes()
            XCTFail("Expecting a fetch recipes failure")
        } catch {
            XCTAssertEqual(error as? MockRecipeDataManagerError, expectedError)
        }
    }

    func test_groupRecipesByCuisine_givenMixOrder_shouldReturnGroupedRecipes() {
        sut = RecipeListViewModel(dataManager: mockRecipeDataManager)

        let britishRecipes: [Recipe] = [
            Recipe(id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                   name: "Apple & Blackberry Crumble",
                   cuisine: "British",
                   smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            Recipe(id: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                   name: "Apple Frangipan Tart",
                   cuisine: "British",
                   smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")
        ]

        let malaysianRecipes: [Recipe] = [
            Recipe(id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                   name: "Apam Balik",
                   cuisine: "Malaysian",
                   smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
        ]

        let canadianRecipes: [Recipe] = [
            Recipe(id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                   name: "BeaverTails",
                   cuisine: "Canadian",
                   smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            Recipe(id: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                   name: "Canadian Butter Tarts",
                   cuisine: "Canadian",
                   smallIconURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")
        ]

        let mixedRecipes = britishRecipes + malaysianRecipes + canadianRecipes
        mockRecipeDataManager.stubResponse = .success(mixedRecipes)

        let expectedRecipes: [String: [Recipe]] = [
            "British": britishRecipes,
            "Canadian": canadianRecipes,
            "Malaysian": malaysianRecipes
        ]

        let groupedRecipes = sut.groupRecipesByCuisine(mixedRecipes)
        XCTAssertEqual(groupedRecipes, expectedRecipes)
    }
}
