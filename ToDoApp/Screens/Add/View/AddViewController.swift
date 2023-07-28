//
//  AddViewController.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

import UIKit

final class AddViewController: UIViewController {
    var viewModel = AddViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
    @IBAction func addTodoButton(_ sender: Any) {
        
        addTodo()
        
        
        
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        
        let signOut = LoginViewController.loadFromNib()
        navigationController?.pushViewController(signOut, animated: false)
        
    }
    
    func addTodo() {
        let ac = UIAlertController(title: "Add Todo", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let todo = ac.textFields![0]
            self.viewModel.post(userId: 5, todo: todo.text ?? "")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        ac.addAction(cancelAction)
        ac.addAction(submitAction)
        
        
        present(ac, animated: true)
    }
    
    private func configure() {
        viewModel.delegate = self
        viewModel.response = { res in
            if case .success(let mesaj) = res {
                let alert = UIAlertController(title: "Success", message: mesaj, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
        }
        title = viewModel.titleName
    }
}

extension AddViewController: AddViewModelDelegate {
    func result(_ response: Response) {
        DispatchQueue.main.async {
            switch response {
            case .success(_):
                return
            case .error(let error):
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
        }
        
    }
}
