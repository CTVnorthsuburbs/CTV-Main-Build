//
//  CategoryViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/3/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
    @IBOutlet weak var tableView: UIView!
    
    
    var category = CategorySearches.recent
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var child: CategoryTableViewController?
    
    

    override func viewDidLoad() {
        

         child = (self.childViewControllers.first as? CategoryTableViewController)!
        

       child?.category = self.category
        
        
   
      

    }
   

    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            
            child?.releaseDateOrder()
            
        //show popular view
        case 1:
            
            child?.nameOrder()
            
        //show history view
        default:
            break;
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    

}
