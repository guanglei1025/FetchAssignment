//
//  RecipeAPIService.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import Foundation

/// Network layer:  Handle API calls

protocol RecipeAPIFetching {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeAPIService: RecipeAPIFetching {

    private let session: URLSessionProtocol

    let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net"
    let path = "recipes.json"

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode
        else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(RecipeResponse.self, from: data).recipes
    }
}

public protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
