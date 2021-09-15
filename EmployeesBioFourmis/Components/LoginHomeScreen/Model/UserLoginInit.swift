//
//  UserLoginInit.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation

class UserLoginInit: Codable{
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    ///Converts the class object into a dictionary
    func asDictionary() -> [String: AnyObject]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return nil}
        return dictionary as [String : AnyObject]?
    }
}
