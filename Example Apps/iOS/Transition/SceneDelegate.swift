//
//  SceneDelegate.swift
//  Transition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import UIKit
import Transition

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = HomeModule(transition: EmbedTransition()).view
        window?.makeKeyAndVisible()
    }
}
