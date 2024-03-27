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
        let testPhotos = [
            Photo(thumbnailUrl: URL(string: "https://via.placeholder.com/150/92c952")!, url: URL(string: "https://via.placeholder.com/600/92c952")!, albumId: "12", id: "12", title: "Apple"),
            Photo(thumbnailUrl: URL(string: "https://via.placeholder.com/150/92c952")!, url: URL(string: "https://via.placeholder.com/600/92c952")!, albumId: "12", id: "12", title: "Apple"),
            Photo(thumbnailUrl: URL(string: "https://via.placeholder.com/150/92c952")!, url: URL(string: "https://via.placeholder.com/600/92c952")!, albumId: "12", id: "12", title: "Apple"),
            Photo(thumbnailUrl: URL(string: "https://via.placeholder.com/150/92c952")!, url: URL(string: "https://via.placeholder.com/600/92c952")!, albumId: "12", id: "12", title: "Apple"),
            Photo(thumbnailUrl: URL(string: "https://via.placeholder.com/150/92c952")!, url: URL(string: "https://via.placeholder.com/600/92c952")!, albumId: "12", id: "12", title: "Apple")
            ]
            
        self.onPhotoLoad?(testPhotos)
    }
}
