//
//  ModalTransition.swift
//
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

/// Allows you to open a new ViewController as a modal window.
public class ModalTransition {
    /// Pass `true` to animate the transition.
    var isAnimated: Bool
    
    /// Wraps `UIViewController` to be opened in `UINavigationController`
    ///
    /// Default `false`
    var isNeedToEmbedInNavigationController: Bool

    /// The presentation style for modal view controllers.
    var modalPresentationStyle: UIModalPresentationStyle?

    /// If `modalPresentationStyle` is `UIModalPresentationStyle.pageSheet` or `UIModalPresentationStyle.formSheet`, these properties will be applied to the opened controller.
    var bottomSheetProps: BottomSheetProps?

    public weak var viewController: UIViewController?

    /// - Parameters:
    ///   - isAnimated: Pass `true` to animate the transition.
    ///   - isNeedToEmbedInNavigationController: wraps `UIViewController` to be opened in `UINavigationController`
    ///   - modalPresentationStyle: The presentation style for modal view controllers.
    ///   - bottomSheetProps: If `modalPresentationStyle` is `UIModalPresentationStyle.pageSheet` or `UIModalPresentationStyle.formSheet`, these properties will be applied to the rendered controller.
    public init(
        isAnimated: Bool = true,
        isNeedToEmbedInNavigationController: Bool = false,
        modalPresentationStyle: UIModalPresentationStyle? = nil,
        bottomSheetProps: BottomSheetProps? = nil
    ) {
        self.isAnimated = isAnimated
        self.isNeedToEmbedInNavigationController = isNeedToEmbedInNavigationController
        self.modalPresentationStyle = modalPresentationStyle
        self.bottomSheetProps = bottomSheetProps
    }
}

// MARK: - Transition

extension ModalTransition: Transition {
    public func open(_ viewController: UIViewController) {
        if let presentationStyle = modalPresentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }
        
        dismissAllPresentedViewControllers(from: viewController)

        setupBottomSheetIfNeeded(viewController)
        
        if isNeedToEmbedInNavigationController {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.prefersLargeTitles = bottomSheetProps?.prefersLargeTitles ?? false
            self.viewController?.present(
                navigationController,
                animated: isAnimated,
                completion: nil
            )
            
        } else {
            self.viewController?.present(
                viewController,
                animated: isAnimated,
                completion: nil
            )
        }
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
    
    func dismissAllPresentedViewControllers(from viewController: UIViewController) {
        if let presentedViewController = viewController.presentedViewController {
            // Dismiss the presented view controller
            presentedViewController.dismiss(animated: true, completion: nil)
            // Recursively call dismissAllPresentedViewControllers on the presented view controller
            dismissAllPresentedViewControllers(from: presentedViewController)
        }
    }
}

// MARK: - Private

private extension ModalTransition {
    func setupBottomSheetIfNeeded(_ viewController: UIViewController) {
        if let sheet = viewController.sheetPresentationController, let props = bottomSheetProps {
            viewController.isModalInPresentation = props.doNotCloseOnDrag
            sheet.detents = props.detents
            sheet.selectedDetentIdentifier = props.selectedDetentIdentifier
            sheet.prefersScrollingExpandsWhenScrolledToEdge = props.prefersScrollingExpandsWhenScrolledToEdge
            sheet.largestUndimmedDetentIdentifier = props.largestUndimmedDetentIdentifier
            sheet.preferredCornerRadius = props.preferredCornerRadius
            sheet.prefersGrabberVisible = props.prefersGrabberVisible
        }
    }
}
