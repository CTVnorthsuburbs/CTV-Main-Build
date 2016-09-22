//
//  MainViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 9/22/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
var logoImageView   : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: Selector("someAction"))
        navigationItem.leftBarButtonItem = button
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
