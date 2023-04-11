//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 31.03.23.
//

import UIKit

final class LoginViewController: UIViewController {
    private let loginScrollView = LoginScrollView()
    override func loadView() {
        super.loadView()
        view = loginScrollView
        if let windowScene = UIApplication.shared.windows.first?.windowScene {
            let interfaceOrientation = windowScene.interfaceOrientation
            if interfaceOrientation.isPortrait {
                NSLayoutConstraint.activate(loginScrollView.portraitConstraints)
            } else {
                NSLayoutConstraint.activate(loginScrollView.landscapeConstraints)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeDeviceOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScrollView.loginScrollViewDelegate = self
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeDeviceOrientation()
    }
    @objc private func changeDeviceOrientation() {
        // Update constraints based on device orientation
        if UIDevice.current.orientation.isPortrait {
            NSLayoutConstraint.deactivate(loginScrollView.landscapeConstraints)
            NSLayoutConstraint.activate(loginScrollView.portraitConstraints)
        } else {
            NSLayoutConstraint.deactivate(loginScrollView.portraitConstraints)
            NSLayoutConstraint.activate(loginScrollView.landscapeConstraints)
        }
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.scrollView.contentInset.bottom = keyboardSize.height + 50.0
            loginScrollView.scrollView.showsVerticalScrollIndicator = false
        }
    }
    @objc private func keyboardWillHide() {
        loginScrollView.scrollView.contentInset = .zero
        loginScrollView.scrollView.verticalScrollIndicatorInsets = .zero
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
        NotificationCenter.default.removeObserver(UIDevice.orientationDidChangeNotification)
    }
}

extension LoginViewController: LoginScrollViewDelegate {
    func pushProfileVC() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
