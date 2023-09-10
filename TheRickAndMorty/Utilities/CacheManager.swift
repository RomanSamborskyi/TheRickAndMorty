//
//  CacheManager.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 05.09.2023.
//

import Foundation
import SwiftUI


class CacheManager {
    
    static let instance = CacheManager()
    var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    private init() { }
    
    func addToCache(for key: String, for image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    func getImageFromCache(for key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
}
