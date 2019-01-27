//
//  LoginViewController.swift
//  prototype
//
//  Created by Humraj Gill on 2019-01-26.
//  Copyright © 2019 Humraj Gill. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension UIViewController {
    func HideKeyboard() {
        let Tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        // Do any additional setup after loading the view.
        
        view.addGestureRecognizer(Tap)
    }
    
    @objc func DismissKeyboard() {
        view.endEditing(true)
    }
}

class LoginViewController: UIViewController {
    
        @IBOutlet weak var UsernameTextField: UITextField!
        @IBOutlet weak var PasswordTextField: UITextField!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            self.HideKeyboard()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            
            /* //check if user is already signed in
             if Auth.auth().currentUser != nil {
             // user is signed in
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
             self.present(vc!, animated: false, completion: nil)
             } else {
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")
             self.present(vc!, animated: false, completion: nil)
             } */
            
        }
        
        @IBAction func SignInTapped(_ sender: Any) {
            let username = UsernameTextField.text
            let password = PasswordTextField.text
            
            Auth.auth().signIn(withEmail: username!, password: password!) { (user, error) in
                if error != nil {
                    // was an error logging in user
                    let alert = UIAlertController(title: "Error", message: "Incorrect username and/or password.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // success
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
                    self.present(vc!, animated: true, completion: nil)
                }
            }
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
