//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 09.03.23.
//

import UIKit

final class FeedViewController: UIViewController {
    private var post = Post(title: "Post")
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 173/255, blue: 181/255, alpha: 1.0)
        button.layer.cornerRadius = 12
        button.setTitle("Go to post", for: .normal)
        button.setTitleColor(UIColor(red: 227/255, green: 253/255, blue: 253/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 227/255, green: 253/255, blue: 253/255, alpha: 1.0)
        view.addSubview(button)
        setupButton()
    }
    private func setupButton() {
        self.view.addSubview(self.button)
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
    }
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
