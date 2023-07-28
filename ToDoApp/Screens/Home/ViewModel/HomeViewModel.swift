//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

final class HomeViewModel {
    let service = APIService()
    
    private var todoModel: ToDoModel?
    
    weak var delegate: HomeViewModelDelegate?
}

extension HomeViewModel {
    var rowCount: Int {
        todoModel?.todos?.count ?? 0
    }
    
    func cellForRowAt(_ row: Int) -> Todo? {
        todoModel?.todos?[row]
    }
    
    func deleteRow(_ row: Int) {
        todoModel?.todos?.remove(at: row)
    }
}

// MARK: GET
extension HomeViewModel {
    func get() {
        service.perform(request: ToDoRequest.todos, response: ToDoModel.self) { result in
            switch result {
                
            case .success(let model):
                self.todoModel = model
                self.delegate?.reloadData()
            case .failure(let error):
                print("❌ \(error)")
            }
        }
    }
    
    
}

// MARK: PUT
extension HomeViewModel {
    func put(todoId: Int, completed: Bool) {
        let model = Completed(completed: completed)
        service.perform(request: ToDoRequest.updateTodo(todoId, model), response: Todo.self) { result in
            switch result {
            case .success(let model):
                if let index = self.todoModel?.todos?.firstIndex(where: {$0.id == model.id}) {
                    self.todoModel?.todos?[index] = model
                }
                
                self.delegate?.reloadData()
            case .failure(let error):
                print("❌ \(error)")
            }
        }
    }
}

// MARK: DELETE
extension HomeViewModel {
    func delete(todoId: Int) {
        service.perform(request: ToDoRequest.deleteTodo(todoId), response: Todo.self) { result in
            switch result {
            case .success(_):
                if let index = self.todoModel?.todos?.firstIndex(where: {$0.id == todoId}) {
                    self.todoModel?.todos?.remove(at: index)
                }
                self.delegate?.reloadData()
            case .failure(let error):
                print("❌ \(error)")
            }
        }
    }
}
