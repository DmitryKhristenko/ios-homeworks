//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 21.03.23.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var post = Post.makePostModel()
    
    private let profileHeaderView = ProfileHeaderView()
    
    private var initialImageRect: CGRect = .zero
    
    private let viewForAnimation: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.alpha = 0
        return view
    }()
    
    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .systemGray2
        button.alpha = 0
        button.addTarget(self, action: #selector(crossButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var animatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotosTableViewCell.delegate = self
        setupView()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func animateImage(_ image: UIImage?, imageFrame: CGRect) {
        view.addSubview(viewForAnimation)
        view.addSubview(animatingImageView)
        viewForAnimation.addSubview(crossButton)

        setupConstraintsForAnimation()
        
        animatingImageView.image = image
        animatingImageView.alpha = 1.0
        animatingImageView.frame = CGRect(x: imageFrame.origin.x,
                                          y: imageFrame.origin.y,
                                          width: imageFrame.width,
                                          height: imageFrame.height)
        
        UIView.animate(withDuration: 0.5) {
            self.viewForAnimation.alpha = 0.4
            self.animatingImageView.frame.size = CGSize(width: UIScreen.main.bounds.width - 10,
                                                        height: UIScreen.main.bounds.width - 10)
            self.animatingImageView.center = self.view.center
            self.animatingImageView.layer.cornerRadius = self.animatingImageView.frame.width / 2
        } completion: { _ in
            UIView.animate(withDuration: 0.01) {
                self.crossButton.layer.cornerRadius = self.crossButton.frame.width / 2
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.crossButton.alpha = 1
                }
            }
        }
    }
    
    @objc private func crossButtonAction() {
        UIView.animate(withDuration: 0.3) {
            self.crossButton.alpha = 0
        } completion: { _ in
            self.animateImageToInitial(rect: self.initialImageRect)
            self.crossButton.removeFromSuperview()
            self.viewForAnimation.removeFromSuperview()
        }
    }
    
    private func animateImageToInitial(rect: CGRect) {
        UIView.animate(withDuration: 0.4) {
            self.animatingImageView.frame = rect
        } completion: { _ in
            self.animatingImageView.removeFromSuperview()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 39),
        ])
    }
    
    private func setupConstraintsForAnimation() {
        NSLayoutConstraint.activate([
            viewForAnimation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewForAnimation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForAnimation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewForAnimation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    
            crossButton.widthAnchor.constraint(equalToConstant: 30),
            crossButton.heightAnchor.constraint(equalToConstant: 30),
            crossButton.topAnchor.constraint(equalTo: viewForAnimation.safeAreaLayoutGuide.topAnchor, constant: 20),
            crossButton.trailingAnchor.constraint(equalTo: viewForAnimation.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
}

// MARK: - PhotosTableViewCellDelegate

extension ProfileViewController: PhotosTableViewCellDelegate {
    func pushPhotosVC() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        post.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post[section].count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { // Special cell for zero index
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell
            // Adjust index path to account for the special cell
            cell?.setupCell(model: post[indexPath.section][indexPath.row - 1])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        profileHeaderView.delegate = self
        profileHeaderView.callBack = { [weak self] rect in
            self?.initialImageRect = rect
        }
        return profileHeaderView
    }
}

// MARK: - ProfileHeaderDelegate

extension ProfileViewController: ProfileHeaderDelegate {
    
    func didTapImage(_ image: UIImage?, imageRect: CGRect) {
        
        let rect = profileHeaderView.frame
        let currentHeaderRect = tableView.convert(rect, to: view)
        initialImageRect = CGRect(x: imageRect.origin.x,
                                  y: imageRect.origin.y + currentHeaderRect.origin.y,
                                  width: imageRect.width,
                                  height: imageRect.height)
        
        animateImage(image, imageFrame: initialImageRect)
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        250
    }
}
