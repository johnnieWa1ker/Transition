//
//  HomeModule.swift
//  Transition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import Foundation
import Transition
import UIKit

final class HomeModule {
    public let view: UIViewController

    public init(
        transition: Transition
    ) {
        let router = HomeRouter()
        router.transition = transition

        let view = HomeViewController(router: router)
        let navigationController = UINavigationController(rootViewController: view)
        self.view = navigationController

        router.viewController = view
    }
}
