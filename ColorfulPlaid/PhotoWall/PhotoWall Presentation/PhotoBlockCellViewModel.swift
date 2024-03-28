//
//  PhotoBlockViewModel.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation
import UIKit

final class PhotoBlockCellViewModel {
    
    typealias Observer<T> = (T) -> Void
    private let model: Photo
    private let imageLoader: ImageDataLoader
    private var imageLoadTask: URLSessionTask?

    var onImageLoad: Observer<UIImage>?
    
    init(model: Photo, imageLoader: ImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    var title: String {
        return model.title
    }
    
    var id: Int {
        return model.id
    }
    
    var albumId: Int {
        return model.albumId
    }
    
    var url: URL {
        return model.url
    }
    
    var thumbnailUrl: URL {
        return model.thumbnailUrl
    }
    
    func loadThumbnailImage() {
        let url = model.thumbnailUrl 
        imageLoadTask = self.imageLoader.load(url: url) { [weak self] result in
            self?.handle(result)
        }
        
    }
    
    private func handle(_ result: ImageLoader.Result) {
        if case let .success(image) = result {
            onImageLoad?(image)
        }
    }
    
    func cancelImageDataLoad() {
        imageLoadTask?.cancel()
        imageLoadTask = nil
    }
    
}

