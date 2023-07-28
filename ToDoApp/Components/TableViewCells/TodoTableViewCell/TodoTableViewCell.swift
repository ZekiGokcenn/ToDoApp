//
//  TodoTableViewCell.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

import UIKit

protocol TodoTableViewCellDelegate: AnyObject {
    func clickedImage(todo: Todo)
}

final class TodoTableViewCell: UITableViewCell {
    @IBOutlet private weak var todoLabel: UILabel!
    @IBOutlet private weak var completedImageView: UIImageView!
    
    private var todo: Todo?
    
    private weak var delegate: TodoTableViewCellDelegate?
    
    func configure(_ todo: Todo, delegate: TodoTableViewCellDelegate?) {
        completedImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickedImage))
        completedImageView.addGestureRecognizer(tap)
        
        todoLabel.text = todo.todo
        completedImageView.image = UIImage(systemName: todo.completed ?? false ? "button.programmable" : "circle")
        
        self.todo = todo
        self.delegate = delegate
    }
}


private extension TodoTableViewCell {
    @objc func clickedImage() {
        delegate?.clickedImage(todo: todo!)
    }
}
