//
//  GreenViewController.swift
//  ExampleTransition
//
//  Created by Johnnie Walker on 28.03.2023.
//

import UIKit

final class GreenViewController: UIViewController {
    // MARK: - Dependencies

    var router: GreenRouter
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.text = "You is coolest 👑"
        $0.adjustsFontSizeToFitWidth = true
        return $0
    }(UILabel())
    
    // MARK: - Initialization

    init(router: GreenRouter) {
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

extension GreenViewController {
    func setupViews() {
        title = "Green"
        view.backgroundColor = .systemGreen
        view.addSubview(titleLabel)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func setupActions() {
        
    }
}

