//
//  YellowModule.swift
//  Transition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import Foundation
import Transition
import UIKit

final class YellowModule {
    public let view: UIViewController

    public init(
        transition: Transition
    ) {
        let router = YellowRouter()
        router.transition = transition

        let view = YellowViewController(router: router)
        self.view = view

        router.viewController = view
    }
}

