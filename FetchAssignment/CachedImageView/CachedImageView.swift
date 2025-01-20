//
//  CachedImageView.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/19/25.
//

import SwiftUI

struct CachedImageView: View {
    @State private var viewModel: CachedImageViewModel

    init(url: String, recipeId: String) {
        _viewModel = State(initialValue: CachedImageViewModel(urlString: url, recipeId: recipeId))
    }

    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: 50, height: 50)
            }
        }
        .task {
            viewModel.getImage()
        }
    }
}

#Preview {
    CachedImageView(
        url: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
        recipeId: "eed6005f-f8c8-451f-98d0-4088e2b40eb6"
    )
    .frame(width: 50, height: 50)
}
