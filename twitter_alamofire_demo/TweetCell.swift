//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            screennameLabel.text = "@\(tweet.user.screen_name)"
            timestampLabel.text = tweet.createdAtString
            retweetLabel.text = "\(tweet.retweetCount)"
            favoriteLabel.text = "\(tweet.favoriteCount ?? 0)"
            
            let profile_url = URL(string: tweet.user.profile_image_url)
            profilePic.af_setImage(withURL: profile_url!)
            
            
            if tweet.favorited == true{
                
                favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
            }
            else
            {
                favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
                
            }
            
            if tweet.retweeted == true
            {
                retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
            }
            else
            {
                retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
                
            }
            
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        
        if tweet.favorited == false
        {
            tweet.favorited = true
            tweet.favoriteCount = tweet.favoriteCount! + 1
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    
                    self.refreshData(tweet: tweet)
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else
        {
            tweet.favorited = false
            tweet.favoriteCount = tweet.favoriteCount! - 1
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error{
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                }
                else if let tweet = tweet{
                    self.refreshData(tweet: tweet)
                    print("Unfavorited!")
                }
            }
        }
        
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
        if tweet.retweeted == false
        {
            tweet.retweeted = true
            tweet.retweetCount = tweet.retweetCount + 1
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error{
                    print("Error retweeting: \(error.localizedDescription)")
                }
                else if let tweet = tweet
                {
                    self.refreshData(tweet: tweet)
                    print("Retweeted!")
                }
            }
            
        }
        else
        {
            tweet.retweeted = false
            tweet.retweetCount = tweet.retweetCount - 1
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let error = error{
                    print("Error unretweeting: \(error.localizedDescription)")
                }
                else if let tweet = tweet{
                    self.refreshData(tweet: tweet)
                    print("Unretweeted!")
                }
            }
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
    
    func refreshData(tweet: Tweet)
    {
        tweetTextLabel.text = tweet.text
        usernameLabel.text = tweet.user.name
        screennameLabel.text = "@\(tweet.user.screen_name)"
        timestampLabel.text = tweet.createdAtString
        retweetLabel.text = "\(tweet.retweetCount)"
        favoriteLabel.text = "\(tweet.favoriteCount ?? 0)"
        
        let profile_url = URL(string: tweet.user.profile_image_url)
        profilePic.af_setImage(withURL: profile_url!)
        
        
        if tweet.favorited == true{
            
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
        }
        else
        {
            favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
            
        }
        
        if tweet.retweeted == true
        {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
        }
        else
        {
            retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
            
        }
        
    }
    
}
