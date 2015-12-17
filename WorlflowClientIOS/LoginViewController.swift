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
        initData()
        initViews()
    }
    override func viewDidAppear(animated: Bool) {
        checkLogin()
    }

    func checkLogin() {
        GetAPI.checkLogin() {
            (response, data, errors) in
            if errors == nil {
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_EMPLOYEE_LOGIN_COMPLETE, object: nil)
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_EMPLOYEE_LOGIN_FAIL, object: nil)
            }
        }
    }

    func initData() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToRootViewController", name: WorkingDataStore.ACTION_EMPLOYEE_LOGIN_COMPLETE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showLoginForm", name: WorkingDataStore.ACTION_EMPLOYEE_LOGIN_FAIL, object: nil)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    func initViews() {
        loginContainer.hidden = true
        loginContainer.layer.borderWidth = 1
        loginContainer.layer.borderColor = UIColor.blackColor().CGColor
    }
    func showLoginForm () {
        loginContainer.hidden = false
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
                do {
                    let parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)

                    if let res = parsedData as? NSDictionary {
                        if res["status"] as! String == "success" {
                            let loginData = res["data"] as! NSDictionary
                            let instance = WorkingDataStore.sharedInstance()
                            instance.setUserId(loginData["userId"] as! String)
                            instance.setAuthToken(loginData["authToken"] as! String)

                            // update user preference
                            let pref = NSUserDefaults.standardUserDefaults()
                            pref.setValue(loginData["userId"] as! String, forKey: "userId")
                            pref.setValue(loginData["authToken"] as! String, forKey: "authToken")

                            NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_EMPLOYEE_LOGIN_COMPLETE, object: nil)
                            return
                        }
                    }
                    print("Login failed")
                } catch {
                    print("Login failed")
                }
            } else {
                print("Login failed")
            }
        }
    }

    func goToRootViewController() {
        dispatch_async(dispatch_get_main_queue()) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let rootViewController = storyBoard.instantiateViewControllerWithIdentifier("RootViewController")
            rootViewController.modalTransitionStyle = .CrossDissolve

            self.presentViewController(rootViewController, animated: true, completion: nil)

            let instance = WorkingDataStore.sharedInstance()
            instance.syncSelf()
            instance.syncTasks()

            self.userName.text = ""
            self.password.text = ""
        }
    }
}
