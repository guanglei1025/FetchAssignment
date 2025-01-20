//
//  CachedImageViewModel.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/19/25.
//

import Foundation
import Observation
import SwiftUI

@Observable
class CachedImageViewModel {
    var image: UIImage?
    var isLoading: Bool = false

    private let urlString: String
    private let recipeId: String

    private let cacheManager = CachedImageManager.shared

    init(urlString: String, recipeId: String) {
        self.urlString = urlString
        self.recipeId = recipeId
    }

    func getImage() {
        if let savedImage = cacheManager.getImage(key: recipeId) {
            image = savedImage
        } else {
            if isLoading == false {
                isLoading = true
                Task {
                    await downloadImage()
                }
            }
        }
    }

    @MainActor
    private func downloadImage() async {
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            guard let image = UIImage(data: data) else {
                isLoading = false
                return
            }
            self.image = image

            // Save Image to cache manager
            cacheManager.addImage(image, key: recipeId)
        } catch {
            // Default image
            self.image = UIImage(systemName: "questionmark.circle")
        }
        isLoading = false
    }
}
