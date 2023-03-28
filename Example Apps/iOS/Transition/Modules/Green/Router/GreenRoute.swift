//
//  GreenRoute.swift
//  Transition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import Foundation
import Transition

protocol GreenRoute {
    func pushGreen()
    func presentGreen()
    func presentGreenAsPageSheet()
    func embededeInSelf()
}

extension GreenRoute where Self: RouterProtocol {
    func pushGreen() {
        let transition = PushTransition()
        let module = GreenModule(transition: transition)
        open(module.view, transition: transition)
    }
    
    func presentGreen() {
        let transition = ModalTransition()
        let module = GreenModule(transition: transition)
        open(module.view, transition: transition)
    }

    func presentGreenAsPageSheet() {
        let transition = ModalTransition(
            isAnimated: true,
            isNeedToEmbedInNavigationController: false,
            modalPresentationStyle: .pageSheet,
            bottomSheetProps: BottomSheetProps(
                doNotCloseOnDrag: false,
                detents: [
                    .large(),
                    .medium()
                ],
                selectedDetentIdentifier: .medium,
                prefersScrollingExpandsWhenScrolledToEdge: true,
                largestUndimmedDetentIdentifier: .medium,
                preferredCornerRadius: 32,
                prefersGrabberVisible: true
            )
        )
        let module = GreenModule(transition: transition)
        open(module.view, transition: transition)
    }
    
    func embededeInSelf() {
        let transition = EmbedTransition()
        let module = GreenModule(transition: transition)
        open(module.view, transition: transition)
    }
}
