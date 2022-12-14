//
//  PushTransition.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

class PushTransition {
    var isAnimated: Bool = true

    weak var viewController: UIViewController?

    init(animated: Bool = true) {
        self.isAnimated = animated
    }
}

// MARK: - Transition

extension PushTransition: Transition {
    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
    }

    func close(_ viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else { return }
        navigationController.popViewController(animated: isAnimated)
    }
}

