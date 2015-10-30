//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Alexis Grubman on 10/28/15.
//  Copyright © 2015 Make School. All rights reserved.
//

import Foundation
import UIKit
import Bond

class PostTableViewCell: UITableViewCell {
    //...
    @IBOutlet var postImageView: UIImageView!
    
    var post: Post? {
        didSet {
            //1
            if let post = post {
                //2
                //bind the image of the post to the 'postImage'view
                post.image.bindTo(postImageView.bnd_image)
            }
        }
    }
}
