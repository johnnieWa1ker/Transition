//
//  PushTransition.swift
//
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public class PushTransition {
    var isAnimated: Bool = true

    public weak var viewController: UIViewController?

    public init(animated: Bool = true) {
        self.isAnimated = animated
    }
}

// MARK: - Transition

extension PushTransition: Transition {
    public func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    public func close(_ viewController: UIViewController) {
        guard
            let navigationController = viewController.navigationController
        else {
            return
        }
        
        navigationController.popViewController(animated: isAnimated)
    }
}
