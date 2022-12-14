//
//  File.swift
//  
//
//  Created by Johnnie Walker on 14.12.2022.
//

import UIKit

public class Router<VC: UIViewController>: RouterProtocol {
    typealias Controller = VC

    var transition: Transition?
    weak var viewController: Controller?
}
