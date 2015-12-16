//
//  LoginViewController.swift
//  WorlflowClientIOS
//
//  Created by Danny Lin on 2015/12/16.
//  Copyright © 2015年 Daz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToRootViewController", name: WorkingDataStore.ACTION_EMPLOYEE_LOGIN_COMPLETE, object: nil)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tapGestureRecognizer)

        setupViews()
    }
    
    func setupViews() {
        loginContainer.layer.borderWidth = 1
        loginContainer.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginButtonClick(sender: AnyObject) {
        dismissKeyboard()

        PostAPI.login(userName.text!, password: password.text!, companyAccount: "") {
            (response: NSURLResponse?, data: NSData?, errors: NSError?) in
            if errors == nil {
                WorkingDataStore.sharedInstance().syncSelf()
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_EMPLOYEE_LOGIN_COMPLETE, object: nil)
            } else {
                print("Login failed")
            }
        }
    }

    func goToRootViewController() {
        dispatch_async(dispatch_get_main_queue()) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = storyBoard.instantiateViewControllerWithIdentifier("RootViewController")

            self.presentViewController(rootViewController, animated: true, completion: nil)
        }
    }
}
