//
//  SceneDelegate.swift
//  MusicApp
//
//  Created by Lauv Edward on 24/07/2021.
//

import UIKit
@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        var contentView: UIViewController!
        if UserPreferences.shared.isSetAppLanguage() {
            contentView = TabbarViewController()
        } else {
            contentView = StartViewController()
        }
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = contentView
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
