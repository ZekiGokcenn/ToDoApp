//
//  LoginViewController.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 26.07.2023.
//

import UIKit
import CoreData

final class LoginViewController: UIViewController {
    @IBOutlet private weak var usernameText: UITextField!
    @IBOutlet private weak var passwordText: UITextField!
    
    var userArray = [String]()
    var passwordArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordText.isSecureTextEntry = true
     
       
        navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Geri butonunu gizle
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

  
  


    @IBAction private func signInButton(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")

        fetchRequest.returnsObjectsAsFaults = false
        appdelegate.saveContext()

        do{
            let results = try context.fetch(fetchRequest)

            for result in results as! [NSManagedObject]{

                if let username = result.value(forKey: "mail") as? String{
                    self.userArray.append(username)
                }
                if let password = result.value(forKey: "password") as? String{
                    self.passwordArray.append(password)
                }

            }
        }
        catch{
            print("error")
        }
        
        if (userArray.contains(usernameText.text!)){
            let userIndex = userArray.firstIndex(where: {$0 == usernameText.text})
            
            if passwordArray[userIndex!] == passwordText.text{
                let login = TabBarController.loadFromNib()
                navigationController?.pushViewController(login, animated: true)
            }
        }
        else{
           
            let alert = UIAlertController(title: "Not Found", message: "No account found for this e-mail address", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func sıgnUpButton(_ sender: Any) {
        let viewModel = SignUpViewModel()
        let vc = SignUpViewController.loadFromNib()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
      }
    
    
    
    
    }
