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

    func loadPhotos() {
        let testPhotos = Photo.loadTestPhotos()
        self.onPhotoLoad?(testPhotos)
    }
}
