//
//  LoginViewController.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 2.01.2024.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController{
    var viewModel = LoginViewModel()
    
    private let welcomeLAbel: UILabel = CustomLabel(text: "WELCOME", labelFont: .boldSystemFont(ofSize: 20))
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile.png")
        iv.contentMode = .scaleAspectFit
        iv.setDimensions(height: 50, width: 50)
        return iv
    }()
    
    private let emailTF = CustomTextField(placeHolder: "Email", keyboardType: .emailAddress)
    private let passwordTF = CustomTextField(placeHolder: "Password", isSecure: true)
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.addTarget(self, action: #selector(handleLoginVC), for: .touchUpInside)
        button.defaultButton(buttonText: "Login")
        return button
    }()
    private lazy var forgetButton: UIButton = {
        let button = UIButton(type: .system)
        button.attrributedText(firstString: "Forgot your password, Get help ", secondString: "Signing In")
        button.setHeight(50)
        button.layer.cornerRadius =  7
        button.addTarget(self, action: #selector(handleForget), for: .touchUpInside)
        return button
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.attrributedText(firstString: "Don't you have account ", secondString: "Sign Up")
        button.setHeight(50)
        button.layer.cornerRadius =  7
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    private let contLabel: UILabel = CustomLabel(text: "or continue with google", labelColor: .lightGray)
    private lazy var googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Google", for: .normal)
        button.backgroundColor = .black
        button.setDimensions(height: 50, width: 150)
        button.layer.cornerRadius =  7
        button.titleLabel?.font = .boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(handleLoginSignIn), for: .touchUpInside)
        return button
    }()
    
    // MARK: -LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureForTextField()

    }
    
    private func configureUI(){
        view.backgroundColor = .white
        
        view.addSubview(welcomeLAbel)
        welcomeLAbel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        welcomeLAbel.centerX(inView: view )
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: welcomeLAbel.bottomAnchor, paddingTop: 15)
        profileImageView.centerX(inView: view )
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTF, passwordTF, loginButton, forgetButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor , left: view.leftAnchor, right: view.rightAnchor , paddingTop: 30, paddingLeft: 30, paddingRight: 30)

        
        view.addSubview(contLabel)
        contLabel.centerX(inView: view, topAnchor: forgetButton.bottomAnchor,paddingTop: 15)
        
        view.addSubview(googleButton)
        googleButton.centerX(inView: view, topAnchor: contLabel.bottomAnchor,paddingTop: 4)
        
        view.addSubview(signUpButton)
        signUpButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 12)
        signUpButton.centerX(inView: view)
        
    }
    private func configureForTextField(){
        emailTF.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(handleTextChanged(sender: )), for: .editingChanged)

    }
    
    @objc func handleLoginVC(){
        guard let email = emailTF.text?.lowercased(), let password = passwordTF.text else {return}
        AuthServices.loginUser(withEmail: email, withPassword: password) { result, error in
            if let error = error {
                print("error:\(error)")
                return
            }
            print("Login succed")
            
            self.navToChattinVC()
        }
    }
    
    @objc func handleForget(){
        
    }
    @objc func handleSignUp(){
        let controller = RegisterViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc func handleLoginSignIn(){
      
    }
    @objc func handleTextChanged(sender: UITextField){
        sender == emailTF ? (viewModel.email = sender.text) :(viewModel.password = sender.text)
        uptadeButton()
    }
    private func uptadeButton(){
        loginButton.isEnabled = viewModel.isEmpty
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
    private func navToChattinVC(){
        guard let userID = Auth.auth().currentUser?.uid else {
            print("error")
            return}
        UserService().fetchUser(uid: userID) { user in
            print("user\(user)")
            let controller = ConversationViewController(user: user)
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)

        }
    }
}


extension LoginViewController : RegisterVC_Delegate{
    func didSuccessRegister(_ Vc: RegisterViewController) {
        Vc.navigationController?.popViewController(animated: true)
        navToChattinVC()
    }
    
    
}
