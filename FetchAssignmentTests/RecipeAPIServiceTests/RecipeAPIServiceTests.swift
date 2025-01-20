//
//  RecipeAPIServiceTests.swift
//  FetchAssignmentTests
//
//  Created by Guanglei Liu on 1/19/25.
//

import XCTest
@testable import FetchAssignment

final class RecipeAPIServiceTests: XCTestCase {

    private var sut: RecipeAPIService!
    private var mockURLSession: MockURLSession!


    let mockJsonString = """
    {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            }
        ]
    }
"""
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }

    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }

    func test_fetchRecipes_usingCorrectURL() async throws {
        let recipeData: Data = mockJsonString.data(using: .utf8)!

        mockURLSession.stubDataResponse = .success((recipeData, URLResponse()))

        sut = RecipeAPIService(session: mockURLSession)

        _ = try await sut.fetchRecipes()
        XCTAssertEqual(mockURLSession.capturedURL?.host(), sut.baseURL)
        XCTAssertEqual(mockURLSession.capturedURL?.path, sut.path)
    }


}
