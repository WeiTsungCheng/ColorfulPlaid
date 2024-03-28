//
//  PhotoWallComposer.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation

final class PhotoWallComposer {
    
    static func photoWallComposedWith(api: some DataLoader, imageLoader: some ImageDataLoader) -> PhotoWallViewController {
        let photoWallViewModel = PhotoWallViewModel(photoAPI:  MainQueueDispatchDecorator(component: api))
        let photoWallViewController = PhotoWallViewController()
        photoWallViewController.viewModel = photoWallViewModel

        photoWallViewModel.loadPhotos()
        
        photoWallViewModel.onPhotoLoad = adaptFeedToCellControllers(forwardingTo: photoWallViewController, imageLoader: MainQueueDispatchDecorator(component: imageLoader))
        
        return photoWallViewController
    }
    
    private static func adaptFeedToCellControllers(forwardingTo controller: PhotoWallViewController, imageLoader: ImageDataLoader) -> ([Photo]) -> Void {
        return { [weak controller] photos in
            controller?.collectionModel = photos.map { model in
                PhotoBlockCellController(viewModel: PhotoBlockCellViewModel(model: model, imageLoader: imageLoader))
            }
        }
    }
}
