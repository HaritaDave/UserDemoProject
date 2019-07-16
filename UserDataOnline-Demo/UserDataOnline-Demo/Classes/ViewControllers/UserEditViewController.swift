//
//  UserEditViewController.swift
//  UserDataOnline-Demo
//
//  Created by harita Bhatt on 16/07/19.
//  Copyright © 2019 Harita Dave. All rights reserved.
//

import UIKit

class UserEditViewController: BaseViewController, UITextFieldDelegate {

    var UserDetail = UserModel()
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtJob: UITextField!
    
    @IBOutlet weak var viewProgress: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
        self.setUserData()
    }

    //MARK: Custom Method
    
    // This Method sets back and edit buttons on the navigation bar
    func setNavigationBar()  {
        self.navigationController?.navigationBar.isHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnEditUser))
        navigationItem.backBarButtonItem?.title = "Back"
        navigationItem.title = "Update User"
    }
    
    func setUserData() {
        self.txtName.text = self.UserDetail.first_name + " " + self.UserDetail.last_name
        self.txtJob.text = "Clerk"
    }
    
    @objc func btnBackView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnEditUser() {
        self.dismissKeyboard()
        self.viewProgress.isHidden = false
        
        UserConnectionClass.PerformUpdateUserDetails(name: txtName.text ?? "", job: txtJob.text ?? "") { (success) in
            self.viewProgress.isHidden = true
            if(success) {
                let alert = UIAlertController(title: "Alert", message: "User data updated successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "User data not updated successfully", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Textfield delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.tag == 100) {
            txtName.resignFirstResponder()
            txtJob.becomeFirstResponder()
        }
        else if (textField.tag == 101) {
            txtJob.resignFirstResponder()
            self.btnEditUser()
        }
        return true
    }
}
