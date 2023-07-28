//
//  DetailViewModel.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 18.07.2023.
//

import Foundation

final class DetailViewModel {
    private let todo: Todo?
    
    init(todo: Todo?) {
        self.todo = todo
    }
    
    var todoName: String? {
        todo?.todo
    }
}
