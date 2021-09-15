//
//  EmployeeListingWorker.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation

class EmployeeListingWorker {
    
    /// Initiate userlist call withpagination
    ///
    ///  - Parameters
    ///  - pageNumber: to have pagination
    ///  - success
    ///  - failure
    func getEmployeeListing(pageNumber: Int = 1, success: @escaping(UserModel) -> Void, failure: @escaping(Error) -> Void) {
        let apiEndPoint = URLManager.sharedInstance.getApiURLForType(apiType: .listUsers)
        guard var urlComponents = URLComponents(string: apiEndPoint) else {
            return
        }
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "\(pageNumber)")]
        guard let urlString = urlComponents.url?.absoluteString else {
            return
        }
        NetworkManager.sharedInstance.request(url: urlString, success: success, failure: failure)
    }
}
