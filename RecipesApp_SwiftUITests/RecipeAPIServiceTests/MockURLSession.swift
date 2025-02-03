//
//  MockURLSession.swift
//  FetchAssignmentTests
//
//  Created by Guanglei Liu on 1/19/25.
//

import Foundation
@testable import FetchAssignment

class MockURLSession: URLSessionProtocol {
    public var stubDataResponse: Result<(Data, URLResponse), Error>?
    public var capturedURL: URL?

    init(){}

    func data(from url: URL) async throws -> (Data, URLResponse) {
        capturedURL = url

        switch stubDataResponse {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        case .none:
            throw MockURLSessionError.stubResponseNotSet
        }
    }
}

enum MockURLSessionError: Error {
    case stubResponseNotSet
}
