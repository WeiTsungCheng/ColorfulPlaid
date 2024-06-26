//
//  SceneDelegate.swift
//  ColorfulPlaid
//
//  Created by WEI-TSUNG CHENG on 2024/3/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let url: URL = URL(string: "https://jsonplaceholder.typicode.com/photos")!
    
    private var api: PhotoAPI {
        return PhotoAPI(url: url)
    }
    
    private let loader = ImageLoader()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let root = HomeUIComposer.homeComposedWith(api: api, loader: loader)
        window.rootViewController = UINavigationController(rootViewController: root)
        self.window = window
        window.makeKeyAndVisible()
    }

}

