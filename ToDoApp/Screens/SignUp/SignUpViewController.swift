//
//  SignUpViewController.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 26.07.2023.
//

import UIKit
import CoreData

final class SignUpViewController: UIViewController {
    @IBOutlet private weak var usernameText: UITextField!
    @IBOutlet private weak var passwordText: UITextField!
    @IBOutlet private weak var verifyPasswordText: UITextField!
    
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordText.isSecureTextEntry = true
        verifyPasswordText.isSecureTextEntry = true
    }
}

// MARK: Private extensions
private extension SignUpViewController {
    @IBAction func signUpButton(_ sender: Any) {
        if viewModel.isUserContains(mail: usernameText.text!) {
            let alert = UIAlertController(title: "Account Exists", message: "There is an account with this email address.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            if passwordText.text == verifyPasswordText.text {
                let alert = UIAlertController(title: "Registration Successful", message: "You are redirected to the login page", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.viewModel.signUp(mail: self.usernameText.text!, password: self.passwordText.text!) {
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Password Error", message: "Passwords do not match", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
                
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
