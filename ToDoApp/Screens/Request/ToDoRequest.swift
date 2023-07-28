//
//  ToDoRequest.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

import Foundation

enum ToDoRequest {
    case todos
    case createTodo(Encodable)
    case updateTodo(Int, Encodable?)
    case deleteTodo(Int)
}

extension ToDoRequest: APIRequest {
    var path: String {
        switch self {
            
        case .todos :
            return "/todos"
        case .createTodo:
            return "/todos/add"
        case .updateTodo(let id, _):
            return "/todos/\(id)"
        case .deleteTodo(let id):
            return "/todos/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .todos:
            return .get
        case .createTodo:
            return .post
        case .updateTodo:
            return .put
        case .deleteTodo:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        [
            HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue
        ]
    }
    
    var queryParams: [String : String]? {
        switch self {
            
        case .todos, .createTodo, .updateTodo, .deleteTodo:
            return nil
        }
    }
    
    var body: Encodable? {
        switch self {
            
        case .todos, .deleteTodo:
            return nil
        case .createTodo(let model):
            return model
        case .updateTodo(_, let model):
            return model
        }
    }
}

