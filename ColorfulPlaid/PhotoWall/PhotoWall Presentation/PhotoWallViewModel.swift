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

    let photoAPI: PhotoAPI
    init(photoAPI: PhotoAPI) {
        self.photoAPI = photoAPI
    }

    func loadPhotos() {
        photoAPI.load() { result in
            
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let response):
                
                    if case .normal(let content) = response.type {
                        
                        if let content = content as? [Photo] {
                            self?.onPhotoLoad?(content)
                            
                        } else {
                            // 處理錯誤邏輯
                        }
                    }
                    
                case .failure(let response):
                    // 處理錯誤邏輯
                    print(response)
                    return
                }
            }
        }
    }
}
