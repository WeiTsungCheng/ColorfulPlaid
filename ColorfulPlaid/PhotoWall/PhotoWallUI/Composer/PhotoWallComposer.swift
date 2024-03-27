//
//  PhotoWallComposer.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation

final class PhotoWallComposer {
    
    static func photoWallComposedWith(api: PhotoAPI, imageLoader: ImageLoader) -> PhotoWallViewController {
        let photoWallViewModel = PhotoWallViewModel(photoAPI: api)
        let photoWallViewController = PhotoWallViewController()
        photoWallViewController.viewModel = photoWallViewModel
        
        photoWallViewModel.onPhotoLoad = adaptFeedToCellControllers(forwardingTo: photoWallViewController, imageLoader: imageLoader)
        
        return photoWallViewController
    }
    
    private static func adaptFeedToCellControllers(forwardingTo controller: PhotoWallViewController, imageLoader: ImageLoader) -> ([Photo]) -> Void {
        return { [weak controller] photos in
            controller?.collectionModel = photos.map { model in
                PhotoBlockCellController(viewModel: PhotoBlockCellViewModel(model: model, imageLoader: imageLoader))
            }
        }
    }
}
