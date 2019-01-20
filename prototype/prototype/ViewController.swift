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
        
        
//        hi im here
        // Configure the cell...
        let post = self.posts[indexPath.row] as! [String: AnyObject]
//        cell.usernameLabel.text = post["username"] as? String
//        cell.titleTextView.text = post["caption"] as? String
        
        
        if let imageName = post["image"] as? String { // find image
            
            // check server storage
            let imageRef = Storage.storage().reference().child("images/\(imageName)")
            imageRef.getData(maxSize: 25 * 1024 * 1024) { (data, error) in          // download image
                if error == nil {
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
                    print("Error downloading image: \(String(describing: error?.localizedDescription))")
                    cell.backgroundColor = UIColor.blue
                    cell.postImageView.isHidden = true
                }
            }
        }
        return cell
    }
    
    
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



}
