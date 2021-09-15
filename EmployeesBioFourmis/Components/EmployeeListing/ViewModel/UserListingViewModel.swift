//
//  UserListingViewModel.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation
import UIKit

extension UserListingViewModel {
    fileprivate struct PageConstants {
        static let title = "Employees List"
    }
}
class UserListingViewModel {
    
    //MARK:- Properties
    private var dataSource = [UserData]()
    
    let apiWorker = EmployeeListingWorker()
    var isPaginating = false
    var pageNumber = 0
    let title = PageConstants.title
    
    //MARK:- Methods
    func setDataSource(data: [UserData]) {
        dataSource = data
    }
    
    func getIndividualEmployeeDataSource(forIndex index: Int) -> UserData? {
        return dataSource[index]
    }
    
    func getNumberOfRows() -> Int {
        return dataSource.count
    }
    
    func getEmployeeDetails(forIndex index: Int) -> (String, String) {
            let firstName = dataSource[index].first_name
            let lastName = dataSource[index].last_name
            let fullName = String(format: "%@ %@", firstName, lastName)
            let email = dataSource[index].email
            return (fullName, email)
    }
    
    func getEmployeeImage(forIndex index: Int) -> UIImage {
            if let imageURL = URL(string: dataSource[index].avatar), let data = try? Data(contentsOf: imageURL) {
                return UIImage(data: data) ?? UIImage()
            }
        return UIImage()
    }
    
    //MARK:- API CALL
    func getEmployeesList(paginate: Bool, completion: @escaping (_ isFailureEncountered: Bool) -> ()) {
        var isFailureEncountered: Bool?
        if paginate {
            isPaginating = true
            pageNumber += 1
        }
        apiWorker.getEmployeeListing() { [weak self] (userData) in
            guard let self = self else {
                return
            }
            self.dataSource.append(contentsOf: userData.data)
            if paginate {
                self.isPaginating = false
            }
            isFailureEncountered = false
            if let isFailureEncountered = isFailureEncountered {
                completion(isFailureEncountered)
            }
        } failure: { [weak self](error) in
            guard let self = self else {
                return
            }
            if paginate {
                self.isPaginating = false
            }
            isFailureEncountered = true
            if let isFailureEncountered = isFailureEncountered {
                completion(isFailureEncountered)
            }
        }
    }
    
}
