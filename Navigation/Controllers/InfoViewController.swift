//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 10.03.23.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.setTitle("Go back", for: .normal)
        button.layer.cornerRadius = 13
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 199/255, blue: 199/255, alpha: 1.0)
        setupButton()
    }
    
    private func setupButton() {
        view.addSubview(backButton)
        backButton.center = view.center
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    @objc private func backAction() {
        let alert = UIAlertController(title: "", message: "Are you sure?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
