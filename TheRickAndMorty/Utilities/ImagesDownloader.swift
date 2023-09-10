//
//  ImagesDownloader.swift
//  TheRickAndMorty
//
//  Created by Roman Samborskyi on 03.09.2023.
//

import Foundation
import Combine
import SwiftUI


class ImagesDownloader: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var isDownload: Bool
    
    var cancelable = Set<AnyCancellable>()
    let imageURL: String
    let imageId: String
    let cache = CacheManager.instance
    let fileManager = LocalFileManager.instance
    
    init(url: String, id: String, download: Bool) {
        imageId = id
        isDownload = download
        imageURL = url
        getimageFromCache()
    }
    
    func getimageFromCache() {
        
        if let returnedImage = cache.getImageFromCache(for: imageURL) {
            image = returnedImage
            //print("Image from cache")
        } else if let imageFromFM = fileManager.getImageFromFileManager(for: imageURL) {
            image = imageFromFM
            //print("Image from file manager")
        } else {
            getImage()
             //print("Download image")
        }
        
    }
    
    func getImage() {
        isLoading = true
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { (data, response) -> UIImage? in
                return UIImage(data: data)
            }
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self else { return }
                if let someImage = returnedImage {
                    self.image = someImage
                    cache.addToCache(for: imageURL, for: someImage)
                    if isDownload {
                        fileManager.saveImageToFileManager(for: imageId, for: someImage)
                    }
                }
            }
            .store(in: &cancelable)
    }
    
}
