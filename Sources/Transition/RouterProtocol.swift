//
//  RouterProtocol.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public protocol RouterProtocol: AnyObject {
    
    associatedtype Controller: UIViewController
    
    var viewController: Controller? { get }
    var transition: Transition? { get set }

    /// Open new controller
    func open(_ viewController: UIViewController, transition: Transition)

    /// Close current controller
    func close()
    func close(completion: @escaping () -> Void)
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

