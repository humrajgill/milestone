//
//  PostViewController.swift
//  Milestone
//
//  Created by Humraj Gill on 2018-09-08.
//  Copyright © 2018 Humraj Gill. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    @IBOutlet weak var TitleTextField: UITextField!  // caption text
//    @IBOutlet weak var DescriptionTextField: UITextView!
    @IBOutlet weak var SelectedImageView: UIImageView!
    @IBOutlet weak var SelectImageButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // Uploading Image Functionality
    
    var imageFileName = ""
    
    @IBAction func SelectImageTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func randomStringWithLength(length: Int) -> NSString {
        let characters: NSString = "abcdefhijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString: NSMutableString = NSMutableString(capacity: length)
        
        for _ in 0..<length {
            let len = UInt32(characters.length)
            let rand = arc4random_uniform(len)
            randomString.appendFormat("%C", characters.character(at: Int(rand)))
        }
        return randomString
    }
    
    func uploadImage(image: UIImage) {
        let randomName = randomStringWithLength(length: 10)
        let imageData = image.jpegData(compressionQuality: 1.0)
        let uploadRef = Storage.storage().reference().child("images/\(randomName).jpg")
        
        let _ = uploadRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil {
                //success
                print("Successfully uploaded image")
                self.imageFileName = "\(randomName as String).jpg"
            } else {
                //error
                print("Error uploading image: \(String(describing: error?.localizedDescription))")
                
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // when cancelled
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // will run when user finishes picking image from photo library
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.SelectedImageView.image = pickedImage
            self.SelectImageButton.isEnabled = false
            self.SelectImageButton.isHidden = true
            uploadImage(image: pickedImage)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    // Posting Fuctionality
    @IBAction func PostTapped(_ sender: Any) {
        
//        if (imageFileName != "") {
            // image has finished uploading, save post
        
            let uid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
                if let userDictionary = snapshot.value as? [String: AnyObject] {
            
                    for user in userDictionary {
                        if let username = user.value as? String {
            
//                                    let caption = TitleTextField.text
            
                                    //Blank Caption
                       /*             if caption == "" {
                                        let alert = UIAlertController(title: "Error", message: "Seems like you have left your caption blank.", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
                                    }
                       */
                    
                                    
                                    let postObject: Dictionary<String, Any> = [
                                        "uid" : uid!,
                                        "username" : username,
//                                        "caption" : caption!,
                                        "image" : self.imageFileName,
                                    ]
                                    Database.database().reference().child("posts").childByAutoId().setValue(postObject)
                                    
                                    print("Posted to Firebase")
                            
                            
                                    let alert = UIAlertController(title: "Success", message: "You have shared your post!", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                
                                // will run when OK is pressed on pop up alert
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
                                self.present(vc!, animated: false, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
//        } else {
//            // image has not finished uploading, give alert
//            let alert = UIAlertController(title: "Still Uploading...", message: "Your image has not finished uploading...", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
        
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
