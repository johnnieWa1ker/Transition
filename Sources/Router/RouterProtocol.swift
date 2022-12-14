//
//  RouterProtocol.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

protocol RouterProtocol: AnyObject {
    
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
    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    func close() {
        guard let currentController = viewController else { return }
        transition?.close(currentController)
    }

    func close(completion: @escaping () -> Void) {
        guard let currentController = viewController else { return }
        transition?.close(currentController, completion: completion)
    }
}

