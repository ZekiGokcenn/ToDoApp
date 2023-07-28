//
//  ToDoModel.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

struct ToDoModel: Codable {
    var todos: [Todo]?
}

struct Todo: Codable {
    let id: Int?
    let todo: String?
    let completed: Bool?
    let userId: Int?
    let isDeleted: Bool?
}


struct Completed: Codable {
    let completed: Bool
}
