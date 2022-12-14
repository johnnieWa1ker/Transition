//
//  ModalTransition.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

class ModalTransition {
    var isAnimated: Bool = true
    var modalPresentationStyle: UIModalPresentationStyle?
    weak var viewController: UIViewController?

    init(
        isAnimated: Bool = true,
        modalPresentationStyle: UIModalPresentationStyle? = nil
    ) {
        self.isAnimated = isAnimated
        self.modalPresentationStyle = modalPresentationStyle
    }
}

// MARK: - Transition

extension ModalTransition: Transition {
    func open(_ viewController: UIViewController) {
        if let presentationStyle = modalPresentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }

        let presentedViewController = self.viewController?.presentedViewController

        guard
            presentedViewController == nil
        else {
            assertionFailure("Can't present \(viewController) while presented \(String(describing: presentedViewController))")
            return
        }
        self.viewController?.present(viewController, animated: isAnimated, completion: nil)
    }

    func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: isAnimated, completion: nil)
    }

    func close(_ viewController: UIViewController, completion: @escaping () -> Void) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}

