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
    
    //For Refreshing tweets on pull
    let myRefreashControl = UIRefreshControl()
    
    @objc func loadTweets(){ //function for reloading tweets from api
        
        numberOfTweets = 20
        
        let tweetsUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count":numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetsUrl, parameters: myParams, success: { (tweets:[NSDictionary]) in
            
            self.tweetArray.removeAll() //clear tweets before reloading
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData() //Make sure to reload data with new tweets params when you call to api
            self.myRefreashControl.endRefreshing() //need to end refreash or else spinning loading bar forever
        }, failure: { (Error) in
            print("Could not load tweets")
        })
    }
    
    func loadMoreTweets(){
        
        numberOfTweets = numberOfTweets + 20 //add 20 to number of tweets whenever you need to load more
        
        //same url as load tweets
        let tweetsUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        let myParams = ["count":numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: tweetsUrl, parameters: myParams, success: { (tweets:[NSDictionary]) in
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData() //Make sure to reload data with new tweets params when you call to api
            self.myRefreashControl.endRefreshing() //need to end refreash or else spinning loading bar forever
        }, failure: { (Error) in
            print("Could not load tweets")
        })
        
    }
    
    //Call loadMoreTweets when you get to end of page
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
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
        
        //set username and tweet content
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        //set profile picture
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        //get if tweet is currently favorited or not
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myRefreashControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreashControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweets() // you fill tweetArray when you load page
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
