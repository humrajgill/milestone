//
//  RegisterViewController.swift
//  prototype
//
//  Created by Humraj Gill on 2019-01-26.
//  Copyright © 2019 Humraj Gill. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Registration
    @IBAction func SignUpTapped(_ sender: Any) {
        let username = UsernameTextField.text
        let email = EmailTextField.text
        let password = PasswordTextField.text
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            if error != nil {
                // error creating account
                let alert = UIAlertController(title: "Error", message: "Something went wrong. " + (error?.localizedDescription)!, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                // success
                
                /*
                 // Successful Registration
                 let alert = UIAlertController(title: "Success", message: "You are now registered!", preferredStyle: .alert)
                 self.present(alert, animated: true, completion: nil)
                 */
                
                //Saving username to database
                if let uid = Auth.auth().currentUser?.uid {
                    let userRef = Database.database().reference().child("users").child(uid)
                    let object = ["username":username]
                    userRef.setValue(object)
                    
                }
                
                // Display main screen
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
                self.present(vc!, animated: true, completion: nil)
                
            }
        }
    }
    
    //Dismiss View Controller
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
