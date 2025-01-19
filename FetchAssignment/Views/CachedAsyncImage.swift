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

fileprivate class ImageCacheManager {

    static let shared  = ImageCacheManager()

    private init() {}

    private var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 20
        cache.totalCostLimit = 20 * 1024 * 1024 // 20MB
        return cache
    }()

    func saveImage(_ image: UIImage, name: String) {
        cache.setObject(image, forKey: name as NSString)
    }

    func getImage(with name: String) -> Image? {
        guard let image = cache.object(forKey: name as NSString) else {
            return nil
        }
        return Image(uiImage: image)
    }
}
