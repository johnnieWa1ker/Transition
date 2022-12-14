//
//  Router.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

open class Router<VC: UIViewController>: RouterProtocol {
    public typealias Controller = VC

    public var transition: Transition?
    public weak var viewController: Controller?
}
