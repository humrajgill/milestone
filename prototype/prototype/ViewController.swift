//
//  ViewController.swift
//  prototype
//
//  Created by Humraj Gill on 2018-11-21.
//  Copyright © 2018 Humraj Gill. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var CollectionView: UICollectionView!
    
    var posts = NSMutableArray()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCollectionViewCell
        
        
        // Configure the cell...
<<<<<<< HEAD
<<<<<<< HEAD
         let post = self.posts[indexPath.row] as! [String: AnyObject]
//         cell.usernameLabel.text = post["username"] as? String
//         cell.titleTextView.text = post["caption"] as? String
=======
=======
>>>>>>> parent of 4c52db8... Added Login & Register
        let post = self.posts[indexPath.row] as! [String: AnyObject]
//        cell.usernameLabel.text = post["username"] as? String
//        cell.titleTextView.text = post["caption"] as? String
>>>>>>> parent of 4c52db8... Added Login & Register
        
        
        if let imageName = post["image"] as? String { // find image
            
            // check server storage
            let imageRef = Storage.storage().reference().child("images/\(imageName)")
            imageRef.getData(maxSize: 25 * 1024 * 1024) { (data, error) in          // download image
                if error == nil {
<<<<<<< HEAD
<<<<<<< HEAD
                     // successful
                    let image = UIImage(data: data!)
                    cell.postImageView.image = image
        
=======
                    // successful
                    let image = UIImage(data: data!)
                    cell.postImageView.image = image
                    
>>>>>>> parent of 4c52db8... Added Login & Register
                    
                    UIView.animate(withDuration: 0.4, animations: {     // animation when image is downloaded
//                        cell.titleTextView.alpha = 1
//                        cell.usernameLabel.alpha = 1
<<<<<<< HEAD
//                        cell.postImageView.alpha = 1
//                    })
                } else {
                    // error
                    print("error")
                    print("Error downloading image: \(String(describing: error?.localizedDescription))")
                }
            }
        }
    return cell
}
=======
                        cell.postImageView.alpha = 1
                    })
                    
                } else {
                    // error
=======
                    // successful
                    let image = UIImage(data: data!)
                    cell.postImageView.image = image
                    
                    
                    UIView.animate(withDuration: 0.4, animations: {     // animation when image is downloaded
//                        cell.titleTextView.alpha = 1
//                        cell.usernameLabel.alpha = 1
                        cell.postImageView.alpha = 1
                    })
                    
                } else {
                    // error
>>>>>>> parent of 4c52db8... Added Login & Register
                    print("not downloaded")
                    print("Error downloading image: \(String(describing: error?.localizedDescription))")
                    cell.backgroundColor = UIColor.blue
                    cell.postImageView.isHidden = true
                }
            }
        }
        return cell
    }
    
>>>>>>> parent of 4c52db8... Added Login & Register
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // CollectionView.dataSource = self
        loadPosts()

    }
    
    func loadPosts() {
        Database.database().reference().child("posts").observeSingleEvent(of: .value) { (DataSnapshot) in
            if let postsDictionary = DataSnapshot.value as? [String: AnyObject] {
                for post in postsDictionary {
                    self.posts.add(post.value)
                }
            }
        }
        self.CollectionView.reloadData()
}

    
    @IBAction func refreshFeed(_ sender: Any) {
        loadPosts()
    }
    
}
