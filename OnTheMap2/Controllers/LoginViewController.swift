//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Pantos, Thomas on 11/3/23.
//

import Foundation
import UIKit

class LoginViewController : UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let udacityURL = URL(string: "https://www.udacity.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewState(isViewClickable: true)
        activityIndicator.isHidden = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
        self.updateViewState(isViewClickable: true)
    }
    
    
    @IBAction func loginRequested(_ sender: Any){
        self.updateViewState(isViewClickable: false)
        UdacityAPI.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion:handleLogInResponse(success:errorMessage:) )
    }
    
    
    func handleLogInResponse(success: Bool, errorMessage: String?){
        if success {
            UdacityAPI.getUserInformationRequest(completion: confirmLogIn(success:error:))
        } else {
            showLoginFailure(message: errorMessage!.localizedLowercase )
        }
    }
    
    
       @IBAction func sendToUdacity(_ sender: Any) {
           UIApplication.shared.open(self.udacityURL)
           
       }
       
       //MARK: Supporting Network Functions
       func postUdacitySession() -> Void {
           
       }
    
    func confirmLogIn(success:Bool, error: Error?){
        if success {
            performSegue(withIdentifier: "LogInSuccessSegue", sender: self)
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    
    func updateViewState(isViewClickable: Bool) -> Void {
        loginButton.isEnabled = isViewClickable
        emailTextField.isEnabled = isViewClickable
        passwordTextField.isEnabled = isViewClickable
        activityIndicator.isHidden = false

        if !isViewClickable {
            activityIndicator.startAnimating()
            
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showLoginFailure(message: String ) {
        let alertVC = UIAlertController(title: "Login failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
        updateViewState(isViewClickable: true)
    }
}



