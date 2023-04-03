//
//  LoginScrollView.swift
//  Navigation
//
//  Created by Дмитрий Х on 31.03.23.
//

import UIKit

protocol LoginScrollViewDelegate: AnyObject {
    func pushProfileVC()
}

final class LoginScrollView: UIView {
    weak var loginScrollViewDelegate: LoginScrollViewDelegate?
    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    private lazy var logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    private lazy var verticalStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
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
     lazy var loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hex: "#4885CC")
        $0.setTitle("Log In", for: .normal)
        $0.layer.cornerRadius = 13.0
        $0.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return $0
    }(UIButton())
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
        // tap gesture recognizer to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(loginButton)
    }
    @objc private func loginButtonPressed() {
        loginScrollViewDelegate?.pushProfileVC()
        loginTextField.text = ""
        passwordTextField.text = ""
        dismissKeyboard()
    }
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    lazy var portraitConstraints: [NSLayoutConstraint] = {
        var constraints = [NSLayoutConstraint]()
        constraints.append(scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor))
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: trailingAnchor))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor))
        constraints.append(contentView.topAnchor.constraint(equalTo: scrollView.topAnchor))
        constraints.append(contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor))
        constraints.append(contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor))
        constraints.append(contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor))
        constraints.append(contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor))
        constraints.append(logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100))
        constraints.append(logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(logoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 120))
        constraints.append(logoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 120))
        constraints.append(verticalStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100))
        constraints.append(verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12))
        constraints.append(verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12))
        constraints.append(loginButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(loginButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 18))
        constraints.append(loginButton.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor))
        constraints.append(loginButton.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor))
        constraints.append(loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        return constraints
    }()
    lazy var landscapeConstraints: [NSLayoutConstraint] = {
        var constraints = [NSLayoutConstraint]()
        constraints.append(scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor))
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor))
        constraints.append(contentView.topAnchor.constraint(equalTo: scrollView.topAnchor))
        constraints.append(contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor))
        constraints.append(contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor))
        constraints.append(contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor))
        constraints.append(contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor))
        constraints.append(logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20))
        constraints.append(logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(logoImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 120))
        constraints.append(logoImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 120))
        constraints.append(verticalStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50))
        constraints.append(verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12))
        constraints.append(verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12))
        constraints.append(loginButton.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(loginButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 14))
        constraints.append(loginButton.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor))
        constraints.append(loginButton.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor))
        constraints.append(loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        return constraints
    }()
}

extension LoginScrollView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
