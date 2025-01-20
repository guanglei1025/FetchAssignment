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

    let expectedURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = RecipeAPIService(session: mockURLSession)
    }

    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }

    func test_fetchRecipes_usingCorrectURL() async throws {
        let data = mockJsonString.data(using: .utf8)!
        let successResponse = HTTPURLResponse(url: expectedURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataResponse = .success((data, successResponse))

        _ = try await sut.fetchRecipes()

        XCTAssertEqual(mockURLSession.capturedURL?.absoluteString, expectedURL.absoluteString)
        XCTAssertEqual(mockURLSession.capturedURL?.host(), "d3jbb8n5wk0qxi.cloudfront.net")
        XCTAssertEqual(mockURLSession.capturedURL?.path(), "/recipes.json")
    }


    func test_fetchRecipes_passValidJSON_getRecipesSuccess() async throws {
        let data = mockJsonString.data(using: .utf8)!
        let successResponse = HTTPURLResponse(url: expectedURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataResponse = .success((data, successResponse))

        let recipes = try await sut.fetchRecipes()

        XCTAssertNotNil(recipes)

        XCTAssertEqual(recipes.count, 1)

        let recipe = recipes.first
        XCTAssertEqual(recipe?.cuisine, "Malaysian")
        XCTAssertEqual(recipe?.name, "Apam Balik")
        XCTAssertEqual(recipe?.id, "0c6ca6e7-e32a-4053-b824-1dbf749910d8")
    }

    func test_fetchRecipes_invalidJSON_throwsDecodingError() async throws {
        let invalidData = "invalid_json".data(using: .utf8)!

        let failureResponse = HTTPURLResponse(url: expectedURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataResponse = .success((invalidData, failureResponse))

        do {
            let _ = try await sut.fetchRecipes()
            XCTFail("Expected to throw DecodingError due to invalid JSON")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_fetchRecipes_errorCode400_throwBadServerResponse() async throws {
        let data = mockJsonString.data(using: .utf8)!
        let failureResponse = HTTPURLResponse(url: expectedURL, statusCode: 400, httpVersion: nil, headerFields: nil)!
        mockURLSession.stubDataResponse = .success((data, failureResponse))

        do {
            let _ = try await sut.fetchRecipes()
            XCTFail("Expected to throw an error for HTTP 400")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badServerResponse, "Expected URLError.badServerResponse for HTTP 400")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
