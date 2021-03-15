//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by MannieC on 3/6/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    @IBAction func retweet(_ sender: Any) {
    }
    
    var favorited:Bool = false //tweets are usually not favorited initially
    
    var tweetId: Int = -1 //set to initial negative number to represent invalid =tweetID
    
    var retweeted:Bool = false 
    
    func setFavorite(_ isFavorited:Bool) {
        //set favorited value by input bool
        favorited = isFavorited
        
        if (favorited){
            //for favorited true then icon = red
            favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }else{
            //set favorite icon to grey
            favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
