//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 21.03.23.
//

import UIKit
import SafariServices

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var post = Post.makePostModel()
    
    private let profileHeaderView = ProfileHeaderView()
    
    private var animation = AnimationForImage()
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotosTableViewCell.delegate = self
        setupView()
        animation.crossButton.addTarget(self, action: #selector(crossButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(postTableView)
        setupConstraints()
    }
    
    @objc func crossButtonAction() {
        UIView.animate(withDuration: 0.3) {
            self.animation.crossButton.alpha = 0
        } completion: { _ in
            self.animation.animateImageToInitial(rect: self.animation.initialImageRect, view: self.view)
            self.animation.crossButton.removeFromSuperview()
            self.animation.blurView.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 39)
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
            self?.animation.initialImageRect = rect
        }
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0 ? true : false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            post[indexPath.section].remove(at: indexPath.row - 1)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

// MARK: - ProfileHeaderDelegate

extension ProfileViewController: ImageAnimationDelegate {
    
    func didTapImage(_ image: UIImage?, imageRect: CGRect) {
        
        let rect = profileHeaderView.frame
        let currentHeaderRect = postTableView.convert(rect, to: view)
        animation.initialImageRect = CGRect(x: imageRect.origin.x,
                                            y: imageRect.origin.y + currentHeaderRect.origin.y,
                                            width: imageRect.width,
                                            height: imageRect.height)
        
        animation.animateImage(image, imageFrame: animation.initialImageRect, view: view, imageHeight: UIScreen.main.bounds.width - 10) {
            self.animation.animatingImageView.frame.width / 2
        }
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
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // Disable selection for the first row, enable for all others
        return indexPath.row == 0 ? false : true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        guard let safeUrl = URL(string: post[0][indexPath.row - 1].urlToWebPage) else { return }
        let safariViewController = SFSafariViewController(url: safeUrl)
        present(safariViewController, animated: true)
    }
    
}
