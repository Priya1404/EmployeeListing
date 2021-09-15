//
//  URLManager.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation

class URLManager {
    
    static let sharedInstance = URLManager()
    
    //MARK:- Base url for app
    private let BASEURL = Bundle.main.infoDictionary?["MY_API_BASE_URL_ENDPOINT"] as? String ?? "https://reqres.in"

    enum APIType: String {
        case login = "/api/login"
        case listUsers = "/api/users"
    }
    
    /// function to return the complete url
    ///
    /// - Parameters:
    ///   - apiType: enum for type of API
    /// - Returns: return the complete url
    public func getApiURLForType(apiType : APIType) -> String{
        return BASEURL + apiType.rawValue
    }
}
