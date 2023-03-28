//
//  HomeViewController.swift
//  ExampleTransition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Dependencies

    var router: HomeRouter

    // MARK: - UI Components

    let pushYellowButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Push yellow", for: .normal)
        return $0
    }(UIButton(type: .system))

    let presentYellowButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Present yellow", for: .normal)
        return $0
    }(UIButton(type: .system))

    let presentYellowInNavigationButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Present yellow embeded in Navigation", for: .normal)
        return $0
    }(UIButton(type: .system))
    
    let presentGreenButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Present green", for: .normal)
        return $0
    }(UIButton(type: .system))

    // MARK: - Initialization

    init(router: HomeRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        setupActions()
    }
}

// MARK: - Setup

extension HomeViewController {
    func setupViews() {
        var yellowButtonConfiguration: UIButton.Configuration = .filled()
        yellowButtonConfiguration.baseBackgroundColor = .systemYellow
        yellowButtonConfiguration.baseForegroundColor = .systemIndigo
        pushYellowButton.configuration = yellowButtonConfiguration
        presentYellowButton.configuration = yellowButtonConfiguration
        presentYellowInNavigationButton.configuration = yellowButtonConfiguration
        
        var greenButtonConfiguration: UIButton.Configuration = .filled()
        greenButtonConfiguration.baseBackgroundColor = .systemGreen
        greenButtonConfiguration.baseForegroundColor = .white
        presentGreenButton.configuration = greenButtonConfiguration

        view.backgroundColor = .systemGray5
        view.addSubview(pushYellowButton)
        view.addSubview(presentYellowButton)
        view.addSubview(presentYellowInNavigationButton)
        view.addSubview(presentGreenButton)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            pushYellowButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            pushYellowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pushYellowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            presentYellowButton.topAnchor.constraint(equalTo: pushYellowButton.bottomAnchor, constant: 16),
            presentYellowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            presentYellowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            presentYellowInNavigationButton.topAnchor.constraint(equalTo: presentYellowButton.bottomAnchor, constant: 16),
            presentYellowInNavigationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            presentYellowInNavigationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            presentGreenButton.topAnchor.constraint(equalTo: presentYellowInNavigationButton.bottomAnchor, constant: 16),
            presentGreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            presentGreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    func setupActions() {
        pushYellowButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.router.pushYellow()
            }),
            for: .touchUpInside
        )
        
        presentYellowButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.router.presentYellow()
            }),
            for: .touchUpInside
        )
        
        presentYellowInNavigationButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.router.presentYellowInNavigation()
            }),
            for: .touchUpInside
        )
        
        presentGreenButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.router.presentGreen()
            }),
            for: .touchUpInside
        )
    }
}
