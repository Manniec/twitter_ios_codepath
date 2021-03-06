//
//  LoginViewController.swift
//  Twitter
//
//  Created by MannieC on 3/5/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func onLoginButton(_ sender: Any) {
        let oauthTokenURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: oauthTokenURL, success: <#T##() -> ()#>, failure: <#T##(Error) -> ()#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
