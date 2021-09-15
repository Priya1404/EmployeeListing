//
//  LoginViewModel.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation
import RxSwift
import RxCocoa

extension LoginViewModel {
    fileprivate struct PageContants {
        //Titles
        static let emailPlaceholder = "Enter email here."
        static let passwordPlaceholder = "Enter password here."
        static let loginButtonTitle = "Login"
        
        //Image
        static let logoImage = "User_Login"
        
        //Sample Credentials
        static let userName = "eve.holt@reqres.in"
        static let password = "password123"
    }
}

class LoginViewModel {
    
    let emailPlaceholder = PageContants.emailPlaceholder
    let passwordPlaceholder = PageContants.passwordPlaceholder
    let loginButtonTitle = PageContants.loginButtonTitle
    let logoImage = PageContants.logoImage
    
    var dataSource: [UserData]?
    
    let apiWorker = LoginWorker()
    
    //Observable
    let userNameTextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    //Check if the User name and password is valid
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(userNameTextPublishSubject.asObservable().startWith("") , passwordTextPublishSubject.asObservable().startWith("")).map { userName, password in
            return userName == PageContants.userName && password == PageContants.password
        }.startWith(false)
    }
    
    //MARK:- API CALL
    func getUserData(email: String, password: String, completion: @escaping (_ isFailureEncountered: Bool) -> ()) {
        var isFailureEncountered: Bool?
        let params = UserLoginInit(email: email, password: password).asDictionary()
        apiWorker.login(userData: params ?? [:]) { (loginData) in
            isFailureEncountered = false
            if let isFailureEncountered = isFailureEncountered {
                completion(isFailureEncountered)
            }
        } failure: { (error) in
            isFailureEncountered = true
            if let isFailureEncountered = isFailureEncountered {
                completion(isFailureEncountered)
            }
        }
    }
    
}
