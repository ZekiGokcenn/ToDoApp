//
//  DetailVC.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 15.07.2023.
//

import UIKit

final class DetailVC: UIViewController {

    var viewModel: DetailViewModel?
    
    @IBOutlet private weak var todoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todoLabel.text = viewModel?.todoName
    }
}
