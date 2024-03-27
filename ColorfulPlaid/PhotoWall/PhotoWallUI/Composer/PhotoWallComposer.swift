//
//  PhotoWallComposer.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation

final class PhotoWallComposer {
    
    static func photoWallComposedWith() -> PhotoWallViewController {
        let photoWallViewModel = PhotoWallViewModel()
        let photoWallViewController = PhotoWallViewController()
        photoWallViewController.viewModel = photoWallViewModel
        
        photoWallViewModel.onPhotoLoad = adaptFeedToCellControllers(forwardingTo: photoWallViewController)
        
        return photoWallViewController
    }
    
    private static func adaptFeedToCellControllers(forwardingTo controller: PhotoWallViewController) -> ([Photo]) -> Void {
        return { [weak controller] photos in
            controller?.collectionModel = photos.map { model in
                PhotoBlockCellController(viewModel: PhotoBlockCellViewModel(model: model))
            }
        }
    }
}
