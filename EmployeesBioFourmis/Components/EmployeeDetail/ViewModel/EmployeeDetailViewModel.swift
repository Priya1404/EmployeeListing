//
//  EmployeeDetailViewModel.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation
import UIKit

class EmployeeDetailViewModel {
    
    //MARK:- Properties
    private var dataSource: UserData?
    
    //MARK:- Set up Data Source
    func setDataSource(data: UserData?) {
        dataSource = data
    }
    
    //MARK:- Methods
    func getEmployeeImage() -> UIImage {
        if let dataSource = dataSource {
            if let imageURL = URL(string: dataSource.avatar), let data = try? Data(contentsOf: imageURL) {
                return UIImage(data: data) ?? UIImage()
            }
        }
        return UIImage()
    }
    
    func getEmployeeName() -> String {
        if let dataSource = dataSource {
            let firstName = dataSource.first_name
            let lastName = dataSource.last_name
            return String(format: "%@ %@", firstName, lastName)
        }
        return ""
    }
    
    func getEmployeeEmail() -> String {
        if let dataSource = dataSource {
            return dataSource.email
        }
        return ""
    }
    
}
