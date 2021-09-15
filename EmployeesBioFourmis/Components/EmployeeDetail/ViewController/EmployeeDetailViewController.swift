//
//  EmployeeDetailViewController.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

    //MARK:- IBOutlet and Properies
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var viewModel = EmployeeDetailViewModel()
    
    //MARK:- Navigator
    static func getComponentViewController() -> UIViewController {
        return UIViewController.getViewControllerWith(storyBoardID: EmployeeConstants.StoryBoardIDS.employeeDetails, ViewControllerID: String(describing: EmployeeDetailViewController.self))
    }
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK:- Set up UI
    func setUpUI() {
        imageView.image = viewModel.getEmployeeImage()
        nameLabel.text = viewModel.getEmployeeName()
        emailLabel.text = viewModel.getEmployeeEmail()
    }
}
