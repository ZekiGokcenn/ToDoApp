//
//  AddViewModel.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 18.07.2023.
//

import Foundation

enum Response {
    case success(String)
    case error(String)
}

protocol AddViewModelDelegate: AnyObject {
    func result(_ response: Response)
}

final class AddViewModel {
    private let service = APIService()
    
    weak var delegate: AddViewModelDelegate?
    
    var response: ((Response) -> Void)?
    
    var titleName = "Ekle"
    
    func post(userId: Int, todo: String) {
        let model = Todo(id: nil, todo: todo, completed: false, userId: userId, isDeleted: nil)
        service.perform(request: ToDoRequest.createTodo(model), response: Todo.self) { result in
            switch result {
            case .success(_):
                self.response?(.success("Ekleme Başarılı"))
            case .failure(let error):
                self.delegate?.result(.error(error.localizedDescription))
            }
        }
    }
}
