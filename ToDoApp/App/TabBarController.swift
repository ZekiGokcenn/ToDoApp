//
//  TabBarController.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self
        navigationItem.setHidesBackButton(true, animated: true)
        
        let tabOne = HomeViewController.loadFromNib()
        let oneNav = UINavigationController(rootViewController: tabOne)
        let oneItem = UITabBarItem(title: "Todos", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        oneNav.tabBarItem = oneItem
        
        let tabTwo = AddViewController.loadFromNib()
        let twoNav = UINavigationController(rootViewController: tabTwo)
        let twoItem = UITabBarItem(title: "Detay", image: UIImage(systemName: "plus.app"), selectedImage: UIImage(systemName: "plus.app.fill"))
        twoNav.tabBarItem = twoItem
        
        self.viewControllers = [oneNav, twoNav]
    }
   
}
