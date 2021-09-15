//
//  LoginWorker.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation

class LoginWorker {
    
    /// Initiate login call with query parameters
    ///
    ///  - Parameters
    ///  - userData: email and password dict
    ///  - success
    ///  - failure
    func login(userData: [String: Any], success: @escaping (LoginModel) -> Void, failure: @escaping (Error) -> Void) {
        let apiEndPoint = URLManager.sharedInstance.getApiURLForType(apiType: .login)
        guard let urlComponents = URLComponents(string: apiEndPoint) else {
            return
        }
        guard let urlString = urlComponents.url?.absoluteString else {
            return
        }
        NetworkManager.sharedInstance.request(url: urlString, dict: userData, success: success, failure: failure)
    }
}
