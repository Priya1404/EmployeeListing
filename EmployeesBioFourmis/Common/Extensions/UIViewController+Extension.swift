//
//  UIViewController+Extension.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// function to return the UIViewController instance
    ///
    /// - Parameters:
    ///   - storyBoardID: enum for type of API
    ///   - ViewControllerID: ViewController ID from storyboard
    /// - Returns: return the corresponding UIViewController
    class func getViewControllerWith(storyBoardID : String , ViewControllerID : String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyBoardID, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: ViewControllerID)
    }
}
