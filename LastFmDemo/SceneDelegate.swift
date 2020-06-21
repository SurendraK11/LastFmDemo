//
//  SceneDelegate.swift
//  LastFmDemo
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let searchListViewController = AlbumsListViewController.instantiate()
        searchListViewController.viewModel = AlbumsListViewModel(withDelegate: searchListViewController)
        window.rootViewController = UINavigationController(rootViewController: searchListViewController)
        
        window.makeKeyAndVisible()
        self.window = window
    }


}

