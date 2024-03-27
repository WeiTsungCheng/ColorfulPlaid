//
//  PhotoBlockViewModel.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation

final class PhotoBlockCellViewModel {
    
    private let model: Photo
    
    init(model: Photo) {
        self.model = model
    }
    
    var title: String {
        return model.title
    }
    
    var id: String {
        return model.id
    }
    
    var url: URL {
        return model.url
    }
    
    var thumbnailUrl: URL {
        return model.thumbnailUrl
    }
}

