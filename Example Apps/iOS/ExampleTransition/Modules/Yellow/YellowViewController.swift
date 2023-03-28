//
//  YellowViewController.swift
//  ExampleTransition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import UIKit

final class YellowViewController: UIViewController {
    // MARK: - Dependencies

    var router: YellowRouter

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.text = "Yellow is cool 😎"
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    
    let pushGreenButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Push green", for: .normal)
        return $0
    }(UIButton(type: .system))

    let presentGreenButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Present green", for: .normal)
        return $0
    }(UIButton(type: .system))

    let embededGreenButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Embeded green (replase self)", for: .normal)
        return $0
    }(UIButton(type: .system))

    // MARK: - Initialization

    init(router: YellowRouter) {
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

extension YellowViewController {
    func setupViews() {
        title = "Yellow"
        view.backgroundColor = .systemYellow

        var greenButtonConfiguration: UIButton.Configuration = .filled()
        greenButtonConfiguration.baseBackgroundColor = .systemGreen
        greenButtonConfiguration.baseForegroundColor = .white
        presentGreenButton.configuration = greenButtonConfiguration
        embededGreenButton.configuration = greenButtonConfiguration
        pushGreenButton.configuration = greenButtonConfiguration

        view.addSubview(titleLabel)
        view.addSubview(pushGreenButton)
        view.addSubview(presentGreenButton)
        view.addSubview(embededGreenButton)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            pushGreenButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
            pushGreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pushGreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            presentGreenButton.topAnchor.constraint(equalTo: pushGreenButton.bottomAnchor, constant: 16),
            presentGreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            presentGreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            embededGreenButton.topAnchor.constraint(equalTo: presentGreenButton.bottomAnchor, constant: 16),
            embededGreenButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            embededGreenButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func setupActions() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .play,
            primaryAction: UIAction(handler: { [weak self] _ in
                self?.handleRightButtonAction()
            })
        )
        
        pushGreenButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.router.pushGreen()
            }),
            for: .touchUpInside
        )

        presentGreenButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.router.presentGreenAsPageSheet()
            }),
            for: .touchUpInside
        )

        embededGreenButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.router.embededeInSelf()
            }),
            for: .touchUpInside
        )
    }
}

// MARK: - Private

private extension YellowViewController {
    func handleRightButtonAction() {
        let alertController = UIAlertController(
            title: "Are you beautiful today?",
            message: "Just a clarifying question to help understand you better.",
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(
            title: "Yes, sure!",
            style: .cancel,
            handler: nil
        ))

        alertController.addAction(UIAlertAction(
            title: "Always beautiful",
            style: .default
        ))

        present(alertController, animated: true)
    }
}
