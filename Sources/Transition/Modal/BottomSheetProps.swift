//
//  BottomSheetProps.swift
//
//
//  Created by Johnnie Walker on 28.01.2023.
//

import Foundation
import UIKit

public struct BottomSheetProps {
    /// A Boolean value indicating whether the view controller enforces a modal behavior.
    ///
    /// The default value of this property is `false`. When you set it to `true`, UIKit ignores events outside the view controller's bounds and prevents the interactive dismissal of the view controller while it is onscreen.
    public let isModalInPresentation: Bool
    
    /// The array of heights where a sheet can rest.
    ///
    /// The default value is an array that contains the value large(). This array must contain at least one element. When you set this value, specify detents in order from smallest to largest height.
    public let detents: [UISheetPresentationController.Detent]
    
    /// The identifier of the most recently selected detent.
    ///
    /// This property represents the most recent detent that the user selects or that you set programmatically. The default value is `nil`, which means the sheet displays at the smallest detent you specify in detents.
    public let selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    
    /// A Boolean value that determines whether scrolling expands the sheet to a larger detent.
    ///
    /// The default value is `true`, which means if the sheet can expand to a larger detent than selectedDetentIdentifier, scrolling up in the sheet increases its detent instead of scrolling the sheet’s content. After the sheet reaches its largest detent, scrolling begins.
    /// Set this value to `false` if you want to avoid letting a scroll gesture expand the sheet. For example, you can set this value on a nonmodal sheet to avoid obscuring the content underneath the sheet.
    public let prefersScrollingExpandsWhenScrolledToEdge: Bool
    
    /// The largest detent that doesn’t dim the view underneath the sheet.
    ///
    /// The default value is `nil`, which means the system adds a noninteractive dimming view underneath the sheet at all detents. Set this property to only add the dimming view at detents larger than the detent you specify. For example, set this property to medium to add the dimming view at the large detent.
    /// Without a dimming view, the undimmed area around the sheet responds to user interaction, allowing for a nonmodal experience. You can use this behavior for sheets with interactive content underneath them.
    public let largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier?
    
    /// The corner radius that the sheet attempts to present with.
    ///
    /// The default value is `nil`. This property only has an effect when the sheet is at the front of its sheet stack.
    public let preferredCornerRadius: CGFloat?
    
    /// A Boolean value that determines whether the sheet shows a grabber at the top.
    ///
    /// The default value is `false`, which means the sheet doesn’t show a grabber. A grabber is a visual affordance that indicates that a sheet is resizable. Showing a grabber may be useful when it isn’t apparent that a sheet can resize or when the sheet can’t dismiss interactively.
    /// Set this value to `true` for the system to draw a grabber in the standard system-defined location. The system automatically hides the grabber at appropriate times, like when the sheet is full screen in a compact-height size class or when another sheet presents on top of it.
    public let prefersGrabberVisible: Bool
    
    /// - Parameters:
    ///   - isModalInPresentation: A Boolean value indicating whether the view controller enforces a modal behavior.
    ///   - detents: The array of heights where a sheet can rest.
    ///   - selectedDetentIdentifier: The identifier of the most recently selected detent.
    ///   - prefersScrollingExpandsWhenScrolledToEdge: A Boolean value that determines whether scrolling expands the sheet to a larger detent.
    ///   - largestUndimmedDetentIdentifier: The largest detent that doesn’t dim the view underneath the sheet.
    ///   - preferredCornerRadius: The corner radius that the sheet attempts to present with.
    ///   - prefersGrabberVisible: A Boolean value that determines whether the sheet shows a grabber at the top.
    public init(
        isModalInPresentation: Bool = false,
        detents: [UISheetPresentationController.Detent] = [.large()],
        selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        prefersScrollingExpandsWhenScrolledToEdge: Bool = true,
        largestUndimmedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = nil,
        preferredCornerRadius: CGFloat? = nil,
        prefersGrabberVisible: Bool = false
    ) {
        self.isModalInPresentation = isModalInPresentation
        self.detents = detents
        self.selectedDetentIdentifier = selectedDetentIdentifier
        self.prefersScrollingExpandsWhenScrolledToEdge = prefersScrollingExpandsWhenScrolledToEdge
        self.largestUndimmedDetentIdentifier = largestUndimmedDetentIdentifier
        self.preferredCornerRadius = preferredCornerRadius
        self.prefersGrabberVisible = prefersGrabberVisible
    }
}
