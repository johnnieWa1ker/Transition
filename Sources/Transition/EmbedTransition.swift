//
//  EmbedTransition.swift
//
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public typealias EmbedTransitionContainer = UIView

public class EmbedTransition {
    public weak var containerView: EmbedTransitionContainer?

    public weak var viewController: UIViewController?

    public init(container: EmbedTransitionContainer? = nil) {
        self.containerView = container
    }
}

// MARK: - Transition

extension EmbedTransition: Transition {
    public func open(_ viewController: UIViewController) {
        guard
            let view = viewController.view,
            let parentController = self.viewController,
            let containerView = containerView ?? parentController.view
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

    public func close(_ viewController: UIViewController, completion: @escaping () -> Void) {
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        completion()
    }
}
