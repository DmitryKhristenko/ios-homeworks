//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 21.03.23.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let profileHeaderView = ProfileHeaderView()
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = view.frame
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    private func setupView() {
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
