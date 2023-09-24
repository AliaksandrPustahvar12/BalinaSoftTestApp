//
//  SceneDelegate.swift
//  BalinaSoftTestApp
//
//  Created by Aliaksandr Pustahvar on 22.09.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = ( scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainView()
        self.window = window
        self.window?.makeKeyAndVisible()
        if let mainViewController = window.rootViewController as? MainViewProtocol {
            let mainController = MainController(view: mainViewController)
            mainViewController.setController(mainController)
        }
    }
}
