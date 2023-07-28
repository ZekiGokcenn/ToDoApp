//
//  UIViewController+Extension.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

import UIKit.UIViewController

extension UIViewController {
    static func loadFromNib() -> Self {
        return Self(nibName: String(describing: self), bundle: nil)
    }
}


extension UIViewController {

    class func loadController() -> Self {
         return Self(nibName: String(describing: self), bundle: nil)
         //Or You can use this as well
         //Self.init(nibName: String(describing: self), bundle: nil)
    }
}
