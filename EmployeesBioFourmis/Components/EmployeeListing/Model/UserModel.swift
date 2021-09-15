//
//  UserModel.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation

class UserModel: Codable {
    let data: [UserData]
    let per_page: Int
    let total_pages: Int
    let page: Int
    let total: Int
}

class UserData: Codable {
    let avatar: String
    let last_name: String
    let first_name: String
    let id: Int
    let email: String
}
