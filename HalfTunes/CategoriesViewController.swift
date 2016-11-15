//
//  CategoriesViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/9/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class CategoriesViewController: UINavigationController {
    
    
    var category: Category?

    override func viewDidLoad() {
        super.viewDidLoad()
        
var child = self.childViewControllers.first as! CategoriesTableViewController
        
        
        if(self.category != nil) {
        child.currentCategory = self.category!
            
        }
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
