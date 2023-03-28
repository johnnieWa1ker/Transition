//
//  GreenModule.swift
//  Transition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import Foundation
import Transition
import UIKit

final class GreenModule {
    public let view: UIViewController

    public init(
        transition: Transition
    ) {
        let router = GreenRouter()
        router.transition = transition

        let view = GreenViewController(router: router)
        self.view = view

        router.viewController = view
    }
}
