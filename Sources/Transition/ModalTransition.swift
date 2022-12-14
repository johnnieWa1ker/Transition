//
//  ModalTransition.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public class ModalTransition {
    var isAnimated: Bool = true
    var modalPresentationStyle: UIModalPresentationStyle?
    public weak var viewController: UIViewController?

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
    public func open(_ viewController: UIViewController) {
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

    public func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: isAnimated, completion: nil)
    }

    public func close(_ viewController: UIViewController, completion: @escaping () -> Void) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}

