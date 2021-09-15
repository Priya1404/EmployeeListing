//
//  NetworkManager.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation

class NetworkManager {
    
    //MARK:- Singleton Instance
    static let sharedInstance = NetworkManager()
    private init() {}
    
    ///Request method to fetch api response
    ///
    /// - Parameters:
    ///   - url: String
    ///   - success: @escaping (Model) -> Void
    ///   - failure: @escaping (Error) -> Void
    func request <Model: Codable> (url: String, dict: [String: Any]? = nil, success: @escaping (Model) -> Void, failure: @escaping (Error) -> Void) {
        guard let uRL = URL(string: url) else {
            return
        }
        var request = URLRequest(url: uRL)
        let jsonData = try? JSONSerialization.data(withJSONObject: dict ?? [:])
        request.httpBody = jsonData
        let session = URLSession.shared.dataTask(with: uRL) { data, response, error in
            do {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    failure(error)
                } else if let data = data {
                    let jsonRes = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response: \(jsonRes)")
                    let json = try JSONDecoder().decode(Model.self, from: data)
                    success(json)
                }
            } catch let error {
                failure(error)
            }
        }
        session.resume()
    }
}
