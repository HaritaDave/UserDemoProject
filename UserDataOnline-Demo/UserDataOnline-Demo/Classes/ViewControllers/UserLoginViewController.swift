//
//  UserLoginViewController.swift
//  PSYCHOnline-Demo
//
//  Created by harita Bhatt on 15/07/19.
//  Copyright © 2019 Harita Dave. All rights reserved.
//

// This class is created for displaying login view controller

import UIKit

class UserLoginViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var viewProgress: UIView!
    
    //MARK: View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad() //Looks for single or multiple taps.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // Custom Button Methods
    //MARK: View Functions
    @IBAction func btnSubmitCliked(_ sender: Any) {
        super.dismissKeyboard()
        
        if(!isValidateLogninDetails(email: txtEmail.text ?? "", password: txtPassword.text ?? "")) {
            let alert = UIAlertController(title: "Alert", message: "Invalid Email or Password. Please try again.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.callSignIn()
        }
    }
    
    //MARK: Call Sign in Methods
    
    func callSignIn() {
        self.viewProgress.isHidden = false
        
        UserConnectionClass.PerformUserLogin(email: txtEmail?.text ?? "", password: txtPassword?.text ?? "") { (success) in
            self.viewProgress.isHidden = true
            
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            
            if (success) {
                // Succcess Login go to Users List screen
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(true, forKey: GlobalConstants.kisUserLoggedIn)
                userDefaults.synchronize() // don't forget this!!!!
                
                let userListViewController = UsersListViewController()
                self.navigationController?.pushViewController(userListViewController, animated: true)
            }
            else {
                let alert = UIAlertController(title: "Alert", message: "Invalid Email or Password. Please try again.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Validation Methods
    
    func isValidateLogninDetails(email: String, password: String) -> Bool {
        if (email.isEmpty || password.isEmpty) {
            return false
        }
        else if  (!isValidEmail(userEmail: email)) {
            return false
        }
        
        return true
    }
    
    func isValidEmail(userEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (!emailTest.evaluate(with: userEmail)) {
            
            let alert = UIAlertController(title: "Alert", message: "Please enter valid Email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    // MARK: Textfield delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.tag == 100) {
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else if (textField.tag == 101) {
            txtPassword.resignFirstResponder()
            self.btnSubmitCliked(AnyObject.self)
        }
        return true
    }
}
