//
//  YellowRoute.swift
//  Transition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import Foundation
import Transition

protocol YellowRoute {
    func presentYellowInNavigation()
    func presentYellow()
    func pushYellow()
}

extension YellowRoute where Self: RouterProtocol {
    func presentYellowInNavigation() {
        let transition = ModalTransition(
            isNeedToEmbedInNavigationController: true,
            modalPresentationStyle: .pageSheet
        )
        let module = YellowModule(transition: transition)
        open(module.view, transition: transition)
    }

    func presentYellow() {
        let transition = ModalTransition()
        let module = YellowModule(transition: transition)
        open(module.view, transition: transition)
    }

    func pushYellow() {
        let transition = PushTransition()
        let module = YellowModule(transition: transition)
        open(module.view, transition: transition)
    }
}
