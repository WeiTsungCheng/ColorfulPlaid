//
//  PhotoWallViewModel.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation

final class PhotoWallViewModel {
    
    private(set) var title: String = "Photo Wall"
    
    typealias Observer<T> = (T) -> Void
    var onPhotoLoad: Observer<[Photo]>?
    var onLoading: Observer<Bool>?
    
    private let photoAPI: DataLoader
    init(photoAPI: DataLoader) {
        self.photoAPI = photoAPI
    }
    
    func loadPhotos(completion: @escaping () -> Void) {
        photoAPI.load() { [weak self] result in
            switch result {
            case .success(let response):
                if case .normal(let content) = response.type {
                    
                    if let content = content as? [Photo] {
                        self?.onPhotoLoad?(content)
                    } else {
                        // 處理錯誤邏輯
                    }
                }
                
            case .failure:
                // 處理錯誤邏輯
                return
            }
            completion()
        }
    }
}
