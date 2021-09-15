//
//  LoginViewControllerViewController.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    //MARK:- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        checkCredentials()
    }
    
    func setUpUI() {
        title = EmployeeConstants.Titles.homepageTitle
        logoImageView.image = UIImage(named: viewModel.logoImage)
        emailTextField.placeholder = viewModel.emailPlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        loginButton.setAttributedTitle(NSAttributedString(string: viewModel.loginButtonTitle, attributes: [.foregroundColor: UIColor.white]), for: .normal)
        loginButton.backgroundColor = UIColor.black
    }
    
    func checkCredentials() {
        emailTextField.rx.text.map{$0 ?? ""}.bind(to: viewModel.userNameTextPublishSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.map{$0 ?? ""}.bind(to: viewModel.passwordTextPublishSubject).disposed(by: disposeBag)
        
        viewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.isValid().map{$0 ? 1 : 0.1}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }
    
    //MARK:- IBActions
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.getUserData(email: email, password: password) { (isFailureEncountered) in
                if isFailureEncountered {
                    print("Failure!!")
                } else {
                    DispatchQueue.main.async {
                        if let viewController = UserListingViewController.getComponentViewController() as? UserListingViewController {
                            self.emailTextField.text = ""
                            self.passwordTextField.text = ""
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }
                }
            }
        }
    }
}
