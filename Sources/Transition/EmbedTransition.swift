//
//  EmbedTransition.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

typealias EmbedTransitionContainer = UIView

class EmbedTransition {
    private weak var containerView: EmbedTransitionContainer?

    weak var viewController: UIViewController?

    init(container: EmbedTransitionContainer? = nil) {
        self.containerView = container
    }
}

// MARK: - Transition

extension EmbedTransition: Transition {
    func open(_ viewController: UIViewController) {
        guard
            let view = viewController.view,
            let parentController = self.viewController,
            let containerView = self.containerView ?? parentController.view
        else {
            return
        }

        viewController.willMove(toParent: parentController)

        parentController.addChild(viewController)
        containerView.addSubview(view)

        viewController.viewWillAppear(false)
        viewController.didMove(toParent: parentController)
        viewController.viewDidAppear(false)

        NSLayoutConstraint.activate([
            viewController.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            viewController.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            viewController.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            viewController.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func close(_ viewController: UIViewController, completion: @escaping () -> Void) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        completion()
    }
}

