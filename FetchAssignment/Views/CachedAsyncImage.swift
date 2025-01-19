//
//  CachedAsyncImage.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/18/25.
//

import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View {

    private let url: URL
    private let content: (AsyncImagePhase) -> Content

    init(url: URL, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }

    var body: some View {
        if let cachedImage = ImageCache[url] {
            content(.success(cachedImage))
        } else {
            AsyncImage(url: url) { phase in
                cacheImage(phase: phase)
            }
        }
    }

    func cacheImage(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

#Preview {
    CachedAsyncImage(url: Recipe.Mock().iconURL!) { phase in
        switch phase {
        case .success(let image):
            image
        case .failure(let error):
            Text("\(error)")
        default:
            ProgressView()
        }
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript (url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        } set {
            ImageCache.cache[url] = newValue
        }
    }
}
