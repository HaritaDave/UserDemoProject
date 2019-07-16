//
//  UsersListViewController.swift
//  PSYCHOnline-Demo
//
//  Created by harita Bhatt on 15/07/19.
//  Copyright © 2019 Harita Dave. All rights reserved.
//

import UIKit

class UsersListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewProgress: UIView!
    @IBOutlet weak var tblUserList: UITableView!
    
    var arrUserList = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblUserList.register(UINib(nibName: "UserDataTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBar()
        self.loadUserData()
    }
    
    //MARK: Custom Method
    func setNavigationBar()  {
        self.navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnSignoutCliked))
        navigationItem.title = "Users List"
    }
    
    //MARK: Load User List Method
    
    func loadUserData() {
        self.viewProgress.isHidden = false
        
        UserConnectionClass.PerformGetUserDetails { (success, arrData) in
            self.viewProgress.isHidden = true
            self.arrUserList.removeAll()
            if (success) {
                self.arrUserList = arrData
            }
            
            self.tblUserList.reloadData()
        }
    }
    
    
    
    //MARK: Button Methods
    @objc func btnSignoutCliked() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(false, forKey: GlobalConstants.kisUserLoggedIn)
        userDefaults.synchronize() // don't forget this!!!!
        
        self.navigationController?.popToRootViewController(animated: true)
    }

    //MARK: Tableview delegate methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserDataTableViewCell
        
        let userDetail = self.arrUserList[indexPath.row] as UserModel
        
        cell.lblName.text = userDetail.first_name + " " + userDetail.last_name
        cell.lblEmail.text = userDetail.email

        cell.imgAvatar.imageFromServerURL(userDetail.avatar, placeHolder: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetail = self.arrUserList[indexPath.row] as UserModel
        
        let userEditViewController = UserEditViewController()
        userEditViewController.UserDetail = userDetail
        self.navigationController?.pushViewController(userEditViewController, animated: true)
    }
}
