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
    var detents: [UISheetPresentationController.Detent]
    
    public weak var viewController: UIViewController?

    public init(
        isAnimated: Bool = true,
        modalPresentationStyle: UIModalPresentationStyle? = nil,
        detents: [UISheetPresentationController.Detent] = [.large()]
    ) {
        self.isAnimated = isAnimated
        self.modalPresentationStyle = modalPresentationStyle
        self.detents = detents
    }
}

// MARK: - Transition

extension ModalTransition: Transition {
    public func open(_ viewController: UIViewController) {
        if let presentationStyle = modalPresentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }

        if let sheet = viewController.sheetPresentationController {
            sheet.detents = detents
        }

        let presentedViewController = self.viewController?.presentedViewController

        guard
            presentedViewController == nil
        else {
            assertionFailure("Can't present \(viewController) while presented \(String(describing: presentedViewController))")
            return
        }

        self.viewController?.present(
            viewController,
            animated: isAnimated,
            completion: nil
        )
    }

    public func close(_ viewController: UIViewController) {
        viewController.dismiss(
            animated: isAnimated,
            completion: nil
        )
    }

    public func close(
        _ viewController: UIViewController,
        completion: @escaping () -> Void
    ) {
        viewController.dismiss(
            animated: isAnimated,
            completion: completion
        )
    }
}
