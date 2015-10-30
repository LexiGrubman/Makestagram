//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Alexis Grubman on 10/22/15.
//  Copyright © 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController {
    

    @IBOutlet var tableView: UITableView!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tabBarController?.delegate = self
    }
    
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper =
            PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
                let post = Post()
                
                post.image.value = image!
                post.uploadPost()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ParseHelper.timelineRequestForCurrentUser {
            (result: [AnyObject]?, error: NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            
            self.tableView.reloadData()
        }
    }
    
}
// MARK: Tab Bar Delegate


extension TimelineViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }

}
    extension TimelineViewController: UITableViewDataSource {
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // 1
            return posts.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            // 2
            let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
            
            let post = posts[indexPath.row]
            //1
            post.downloadImage()
            //2
            cell.post = post
            
            return cell
        }
        
}