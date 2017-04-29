//
//  NewsFeedTableViewCell.swift
//  ios-base
//

import UIKit
import Parse

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet var postNameLabel: UILabel?
    @IBOutlet var usernameButton: UIButton?
    @IBOutlet var postContentLabel: UILabel?
    @IBOutlet var timestampLabel: UILabel?
    var parent: NewsFeedViewController?
    var username: String?
    
    func loadData(post: Post, parent: NewsFeedViewController) {
        self.parent = parent
        self.username = post.pfObject["username"] as? String
        postNameLabel?.text = post.pfObject["postName"] as? String
        usernameButton?.setTitle(self.username, for: UIControlState.normal)
        postContentLabel?.text = post.pfObject["content"] as? String
        timestampLabel?.text = post.pfObject["timeStamp"] as? String
        postContentLabel?.sizeToFit()
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
//        if let user = self.user {
//            self.parent?.viewProfile(user: user)
//        }
        
        let query = PFUser.query()
        // want the posts in reverse order
        query?.whereKey("username", equalTo: self.username ?? "Unknown User")
        query?.getFirstObjectInBackground {
            (object, error) -> Void in
            if error != nil || object == nil {
                print("The getFirstObject request failed.")
            } else {
                // The find succeeded.
                print("Successfully retrieved the object.")
                self.parent?.viewProfile(user: object as! PFUser)
            }
        }
        
        
    }
}
