//
//  UserListingViewController.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import UIKit

class UserListingViewController: UIViewController {
    
    //MARK:- IBOutlets and Properties
    @IBOutlet weak var tableView: UITableView!
    
    var isUserLoggedIn = true
    
    //ViewModel
    var viewModel = UserListingViewModel()
    
    //MARK:- Navigator
    static func getComponentViewController() -> UIViewController {
        return UIViewController.getViewControllerWith(storyBoardID: EmployeeConstants.StoryBoardIDS.userListing, ViewControllerID: String(describing: UserListingViewController.self))
    }
    
    //MARK:- ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpTableView()
        getUserDetails()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: EmployeeConstants.Titles.logout, style: .done, target: self, action: #selector(logOutUser))
    }
    
    ///Log out the user
    ///
    ///   - reset the data source to empty
    ///    - hide the empty tableView
    ///     -- reload to display the updated results
    @objc func logOutUser() {
        isUserLoggedIn = false
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Set Up UI
    func setUpUI() {
        title = viewModel.title
    }
    
    //MARK:- Set up Tableview
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getUserDetails(paginate: Bool = false) {
        self.view.showLoader()
        viewModel.getEmployeesList(paginate: paginate) { [weak self] (isFailureEncountered) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.view.dismissloader()
                if !isFailureEncountered {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK:- Tableview Delegate Methods
extension UserListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmployeeTableViewCell.self), for: indexPath) as? EmployeeTableViewCell {
            let employeeDetail = viewModel.getEmployeeDetails(forIndex: indexPath.row)
            cell.updateEmployeeDetails(name: employeeDetail.0, email: employeeDetail.1)
            cell.updateEmployeeImage(image: viewModel.getEmployeeImage(forIndex: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getNumberOfRows() - 1 {
            getUserDetails(paginate: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = EmployeeDetailViewController.getComponentViewController() as? EmployeeDetailViewController {
            viewController.viewModel.setDataSource(data: viewModel.getIndividualEmployeeDataSource(forIndex: indexPath.row))
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
