//
//  CachedImageManager.swift
//  FetchAssignment
//
//  Created by Guanglei Liu on 1/19/25.
//

import Foundation
import SwiftUI

class CachedImageManager {
    static let shared = CachedImageManager()

    private init() {}

    private var cache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1024 * 1024 // 100MB
        return cache
    }()

    func addImage(_ image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func getImage(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
