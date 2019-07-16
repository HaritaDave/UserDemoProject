//
//  BaseViewController.swift
//  PSYCHOnline-Demo
//
//  Created by harita Bhatt on 15/07/19.
//  Copyright © 2019 Harita Dave. All rights reserved.
//

/*
 * This class is used as a base view controller class which contains
 * all the basic methods and classes needed to be used with all the classes
 *
 */

import UIKit

class BaseViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // BG Color for all views
        self.view.backgroundColor = UIColor.init(white: 1, alpha: 1);
        
        
        // Tap geture to remove key board
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Remove tap geture on table click event
        tap.cancelsTouchesInView = false

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        // tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
