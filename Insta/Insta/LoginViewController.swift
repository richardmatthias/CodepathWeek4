//
//  LoginViewController.swift
//  Insta
//
//  Created by Langtian Qin on 2/27/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    //Outlet And Outlet Reaction functions
    @IBOutlet weak var SignupButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    @IBAction func LoginTrigger(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func signupTrigger(_ sender: Any) {
        registerUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Helper Functions
    func registerUser() {
        let alertController = UIAlertController(title: "Invalid Signup", message: "Invalid Signup Credentials. Please change username and password and try again.", preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = UsernameField.text
        newUser.password = PasswordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    func loginUser() {
        let alertController = UIAlertController(title: "Invalid Login", message: "Invalid Login Credentials. Please check username and password.", preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        let username = UsernameField.text ?? ""
        let password = PasswordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
