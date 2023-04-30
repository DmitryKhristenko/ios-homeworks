//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Х on 31.03.23.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let testLogin = "E@e.ru"
    private let testPassword = "qwe"
        
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private lazy var contentView: UIView = {
        return $0
    }(UIView())
    
    private lazy var logoImageView: UIImageView = {
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var verticalStackView: UIStackView = {
        $0.addArrangedSubview(loginTextField)
        $0.addArrangedSubview(passwordTextField)
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray3.cgColor
        $0.clipsToBounds = true
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private lazy var loginTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Email or phone"
        $0.text = "E@e.ru"
        $0.delegate = self
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .black
        $0.backgroundColor = .systemGray6
        $0.setLeftPaddingPoints(5)
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())
    
    private lazy var passwordTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "qwe"
        $0.placeholder = "Password"
        $0.delegate = self
        $0.isSecureTextEntry = true
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .black
        $0.backgroundColor = .systemGray6
        $0.setLeftPaddingPoints(5)
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())
    
    private lazy var passwordErrorLabel: UILabel = {
        $0.textColor = .systemRed
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.text = "Password must be at least 3 characters"
        $0.numberOfLines = 0
        $0.alpha = 0
        return $0
    }(UILabel())
    
    private lazy var loginButton: UIButton = {
        $0.backgroundColor = UIColor(hex: "#4885CC")
        $0.setTitle("Log In", for: .normal)
        $0.layer.cornerRadius = 13.0
        $0.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // The purpose of using this variable is to avoid unnecessary constraint changes when the device rotates back and forth between portrait and landscape orientations. viewWillAppear and viewWillTransition methods use it.
    private var isLandscapeOrientation: Bool?
    
    // These constraints are created and activated/deactivated depending on the device orientation in viewWillDisappear, setupConstraints and viewWillTransition methods.
    private var scrollViewLeadingPortrait: NSLayoutConstraint?
    private var scrollViewLeadingLandscape: NSLayoutConstraint?
    
    private var scrollViewTrailingPortrait: NSLayoutConstraint?
    private var scrollViewTrailingLandscape: NSLayoutConstraint?
    
    private var logoImageViewPortrait: NSLayoutConstraint?
    private var logoImageViewLandscape: NSLayoutConstraint?
    
    private var verticalStackViewPortrait: NSLayoutConstraint?
    private var verticalStackViewLandscape: NSLayoutConstraint?
    
    private var loginButtonPortrait: NSLayoutConstraint?
    private var loginButtonLandscape: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        isLandscapeOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape
        setupConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
        activateOrDeactivateConstraints(shouldActivate: false, constraints: [scrollViewLeadingLandscape, scrollViewTrailingLandscape, logoImageViewLandscape, verticalStackViewLandscape, loginButtonLandscape, scrollViewLeadingPortrait, scrollViewTrailingPortrait, logoImageViewPortrait, verticalStackViewPortrait, loginButtonPortrait])
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.addSubview(scrollView)
        // tap gesture recogniser to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
        [contentView, logoImageView, verticalStackView, passwordErrorLabel, loginButton].forEach { scrollView.addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height + 50.0
        }
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginButtonPressed() {
        guard let safeLoginTextField = loginTextField.text else { return }
        guard let safePasswordTextField = passwordTextField.text else { return }
        
        switch (safeLoginTextField.isEmpty, safePasswordTextField.isEmpty, isPasswordValid(safePasswordTextField)) {
            
        case (true, _, _), (_, true, _):
            shakeAnimation(objectToAnimate: verticalStackView)
            redAnimationForTextField(textField: loginTextField)
            redAnimationForTextField(textField: passwordTextField)
            
        case (_, _, true):
            if safeLoginTextField != testLogin || safePasswordTextField != testPassword {
                let alert = UIAlertController(title: "Invalid username or password", message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okAction)
                if isEmailValid(rawValue: safeLoginTextField) == true {
                    present(alert, animated: true)
                } else {
                    if safeLoginTextField != testLogin {
                        let messageAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
                        let attributedMessage = NSAttributedString(string: "\"\(safeLoginTextField)\" is not a valid email address", attributes: messageAttributes)
                        alert.setValue(attributedMessage, forKey: "attributedMessage")
                        present(alert, animated: true)
                        loginTextField.text = ""
                    } else {
                        present(alert, animated: true)
                    }
                }
            } else {
                navigationController?.pushViewController(ProfileViewController(), animated: true)
                dismissKeyboard()
                loginTextField.text = ""
                passwordTextField.text = ""
            }
            
        case (_, _, false):
            shakeAnimation(objectToAnimate: verticalStackView)
            UIView.animate(withDuration: 1) {
                self.passwordErrorLabel.alpha = 1
            }
        }
    }
    
    private func isEmailValid(rawValue: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        let evalResult = emailPredicate.evaluate(with: rawValue)
        return evalResult ? true : false
    }
    
    private func isPasswordValid(_ password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.{3,}$")
        return passwordTest.evaluate(with: password)
    }
    
    private func redAnimationForTextField(textField: UITextField) {
        guard let safeTextField = textField.text else { return }
        if safeTextField.isEmpty {
            UIView.animate(withDuration: 0.4) {
                textField.backgroundColor = .systemRed
                textField.alpha = 0.5
            } completion: { _ in
                UIView.animate(withDuration: 0.7) {
                    textField.backgroundColor = .systemGray6
                    textField.alpha = 1
                }
            }
        }
    }
    
    private func activateOrDeactivateConstraints(shouldActivate: Bool, constraints: [NSLayoutConstraint?]) {
        constraints.forEach { constraint in
            if let constraint = constraint {
                constraint.isActive = shouldActivate
            }
        }
    }
    
    private func setupConstraints() {
        // This method sets up the constraints based on the current device orientation. The "setupConstraints" method activates the appropriate constraints and "viewWillTransition" method deactivates constraints that are not needed for the current orientation.
        switch UIApplication.shared.windows.first?.windowScene?.interfaceOrientation {
        case .portrait:
            scrollViewLeadingPortrait = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            scrollViewTrailingPortrait = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)

            logoImageViewPortrait = logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 200)

            verticalStackViewPortrait = verticalStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100)

            loginButtonPortrait = loginButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 27)
            
            activateOrDeactivateConstraints(shouldActivate: true, constraints: [scrollViewLeadingPortrait, scrollViewTrailingPortrait, logoImageViewPortrait, verticalStackViewPortrait, loginButtonPortrait])
            
        case .landscapeLeft, .landscapeRight:

            scrollViewLeadingLandscape = scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            scrollViewTrailingLandscape = scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)

            logoImageViewLandscape = logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)

            verticalStackViewLandscape = verticalStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50)

            loginButtonLandscape = loginButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 22)
            
            activateOrDeactivateConstraints(shouldActivate: true, constraints: [scrollViewLeadingLandscape, scrollViewTrailingLandscape, logoImageViewLandscape, verticalStackViewLandscape, loginButtonLandscape])
            
        default:
            break
        }
        
        NSLayoutConstraint.activate([
            // both device orientations use these constraints
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 120),
            logoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            passwordErrorLabel.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 4),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 3),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Override Methods
    // This method deactivates the constraints when the device's orientation changes and then call setupConstraints().
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Check if the view controller's view is loaded and is currently in the view hierarchy
        guard isViewLoaded && view.window != nil else {
            return
        }
        
        // Update constraints based on device orientation
        if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait == true {
            isLandscapeOrientation = false
            activateOrDeactivateConstraints(shouldActivate: false, constraints: [scrollViewLeadingLandscape, scrollViewTrailingLandscape, logoImageViewLandscape, verticalStackViewLandscape, loginButtonLandscape])
        } else if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait == false {
            if isLandscapeOrientation == true {
                return
            } else {
                activateOrDeactivateConstraints(shouldActivate: false, constraints: [scrollViewLeadingPortrait, scrollViewTrailingPortrait, logoImageViewPortrait, verticalStackViewPortrait, loginButtonPortrait])
                isLandscapeOrientation = true
            }
        }
        setupConstraints()
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let safePasswordText = passwordTextField.text else { return }
        UIView.animate(withDuration: 0.6) {
            if self.isPasswordValid(safePasswordText) {
                self.passwordErrorLabel.alpha = 0
            }
        }
    }
}
