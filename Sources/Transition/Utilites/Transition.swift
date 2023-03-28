//
//  Transition.swift
//
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }
    func open(_ viewController: UIViewController)
    func close(_ viewController: UIViewController)
    func close(_ viewController: UIViewController, completion: @escaping () -> Void)
}

public extension Transition {
    func close(_ viewController: UIViewController) {
        close(viewController, completion: {})
    }

    func close(_: UIViewController, completion: @escaping () -> Void) {
        completion()
    }
}
