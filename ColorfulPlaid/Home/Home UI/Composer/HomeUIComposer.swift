//
//  HomeUIComposer.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/27.
//

import Foundation
import UIKit

final class HomeUIComposer {
    
    static func homeComposedWith() -> HomeViewController {
        
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController()
        homeViewController.viewModel = homeViewModel
        
        homeViewModel.navigateToNextPage = {
            let api = PhotoAPI()
            let photoWallViewController = PhotoWallComposer.photoWallComposedWith(api: api)
            if let navigationController = homeViewController.navigationController {
                navigationController.pushViewController(photoWallViewController, animated: false)
            }
        }
        
        return homeViewController
    }
}
