//
//  SignUpViewModel.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 28.07.2023.
//

import CoreData
import UIKit.UIApplication

final class SignUpViewModel {
    private var userArray = [String]()
    
    func signUp(mail: String, password: String, completion: () -> Void) {
        let passwordRegPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let info = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        fetchRequest.returnsObjectsAsFaults = false
        
        info.setValue(mail, forKey: "mail")
        info.setValue(password, forKey: "password")
        
        appDelegate.saveContext()
        
        completion()
    }
    
    func fetchUsers() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let user = result.value(forKey: "mail") as? String{
                    userArray.append(user)
                }
            }
        }
        catch{
            print("error")
        }
    }
    
    func isUserContains(mail: String) -> Bool {
        userArray.contains(mail)
    }
}
