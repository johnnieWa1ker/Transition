//
//  File.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public class Router<VC: UIViewController>: RouterProtocol {
    typealias Controller = VC

    public var transition: Transition?
    public weak var viewController: Controller?
}
