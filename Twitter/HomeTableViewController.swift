//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by MannieC on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    //Create dictionary to store tweets in
    var tweetArray = [NSDictionary]()
    var numberOfTweets : Int!
    
    func loadTweet(){
        
        let tweetsUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count":10]
        
        self.tweetArray.removeAll() //clear tweets before reloading
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetsUrl, parameters: myParams, success: { (tweets:[NSDictionary]) in
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData() //Make sure to reload data with new tweets params when you call to api
            
        }, failure: { (Error) in
            print("Could not load tweets")
        })
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout() //this logs you out
        self.dismiss(animated: true, completion: nil) //this returns you to login page
        UserDefaults.standard.set(false, forKey: "userLoggedIn")//Set userLoggedIn value to false
    }
    
    //For displaying tweet cells (in addition to sections)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        //casting cell as type TweetCellTableViewCell gives u access to the linked outlets
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet() // you fill tweetArray when you load page
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count //return number of loaded/retrieved tweets
    }


}
