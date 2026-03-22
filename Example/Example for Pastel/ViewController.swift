//
//  ViewController.swift
//  Pastel
//
//  Created by cruz on 05/05/2017.
//  Copyright (c) 2017 cruz. All rights reserved.
//

import UIKit
import SwiftUI
import Pastel

class ViewController: UIViewController {

    private let usernameField = UITextField()
    private let passwordField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPastelBackground()
        setupLoginUI()
    }

    // MARK: - Private

    private func setupPastelBackground() {
        let pastelView = PastelView(frame: view.bounds)
        pastelView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        pastelView.animationDuration = 3.0
        pastelView.setColors([
            UIColor(red: 156/255, green: 39/255,  blue: 176/255, alpha: 1.0),
            UIColor(red: 255/255, green: 64/255,  blue: 129/255, alpha: 1.0),
            UIColor(red: 123/255, green: 31/255,  blue: 162/255, alpha: 1.0),
            UIColor(red: 32/255,  green: 76/255,  blue: 255/255, alpha: 1.0),
            UIColor(red: 32/255,  green: 158/255, blue: 255/255, alpha: 1.0),
            UIColor(red: 90/255,  green: 120/255, blue: 127/255, alpha: 1.0),
            UIColor(red: 58/255,  green: 255/255, blue: 217/255, alpha: 1.0),
        ])
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }

    private func setupLoginUI() {
        // Logo
        let logoView = PastelImageView(frame: .zero)
        logoView.image = UIImage(named: "Instagram Text Logo")
        logoView.setColors(PastelGradient.malibuBeach.colors())
        logoView.startAnimation()
        logoView.translatesAutoresizingMaskIntoConstraints = false

        // Username field
        styleTextField(usernameField, placeholder: "Username")

        // Password field
        styleTextField(passwordField, placeholder: "Password")
        passwordField.isSecureTextEntry = true

        // Login button
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        loginButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        loginButton.layer.cornerRadius = 6
        loginButton.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        loginButton.layer.borderWidth = 1
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(showComponents), for: .touchUpInside)

        // Forgot password
        let forgotButton = UIButton(type: .system)
        forgotButton.setTitle("Forgot password?", for: .normal)
        forgotButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        forgotButton.titleLabel?.font = .systemFont(ofSize: 14)
        forgotButton.translatesAutoresizingMaskIntoConstraints = false

        // Stack
        let stack = UIStackView(arrangedSubviews: [
            usernameField, passwordField, loginButton, forgotButton
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(logoView)
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -48),
            logoView.widthAnchor.constraint(equalToConstant: 200),
            logoView.heightAnchor.constraint(equalToConstant: 80),

            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            usernameField.heightAnchor.constraint(equalToConstant: 46),
            passwordField.heightAnchor.constraint(equalToConstant: 46),
            loginButton.heightAnchor.constraint(equalToConstant: 46),
        ])
    }

    private func styleTextField(_ field: UITextField, placeholder: String) {
        field.placeholder = placeholder
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
        field.textColor = .white
        field.font = .systemFont(ofSize: 16)
        field.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        field.layer.cornerRadius = 6
        field.layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        field.layer.borderWidth = 1
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func showComponents() {
        let hostingController = UIHostingController(rootView: DemoView())
        hostingController.modalPresentationStyle = .pageSheet
        present(hostingController, animated: true)
    }
}
