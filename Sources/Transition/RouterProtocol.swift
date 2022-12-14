//
//  RouterProtocol.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public protocol RouterProtocol: AnyObject {
    
    public associatedtype Controller: UIViewController
    
    public var viewController: Controller? { get }
    public var transition: Transition? { get set }

    /// Open new controller
    public func open(_ viewController: UIViewController, transition: Transition)

    /// Close current controller
    public func close()
    public func close(completion: @escaping () -> Void)
}

extension RouterProtocol {
    public func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    public func close() {
        guard let currentController = viewController else { return }
        transition?.close(currentController)
    }

    public func close(completion: @escaping () -> Void) {
        guard let currentController = viewController else { return }
        transition?.close(currentController, completion: completion)
    }
}

