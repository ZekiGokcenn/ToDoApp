//
//  HomeViewController.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewModelBind()
        tableViewRegister()
        
    }
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { fatalError() }
        guard let model = viewModel.cellForRowAt(indexPath.row) else { return UITableViewCell()}
        cell.configure(model, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC.loadFromNib()
        vc.viewModel = DetailViewModel(todo: viewModel.cellForRowAt(indexPath.row))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            
            guard let id = viewModel.cellForRowAt(indexPath.row)?.id  else { return }
            viewModel.delete(todoId: id)
        }
    }
}



extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

extension HomeViewController: TodoTableViewCellDelegate {
    func clickedImage(todo: Todo) {
        viewModel.put(todoId: todo.id!, completed: !(todo.completed!))
    }
    
    
}

private extension HomeViewController {
    func viewModelBind() {
        viewModel.delegate = self
        viewModel.get()
    }
    
    func tableViewRegister() {
        tableView.register(cell: TodoTableViewCell.self)
    }
}

extension UITableView {
    func register(cell: UITableViewCell.Type) {
        
        let bundle = Bundle(for: cell.self)
        let nib = UINib(nibName: cell.identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
}

extension UIResponder {
    static var identifier: String {
        String(describing: self.self)
    }
}
