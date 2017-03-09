//
//  CategoryViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 11/3/16.
//  
//

import UIKit

class CategoryViewController: UIViewController {

  
    @IBOutlet weak var tableView: UIView!
    
    
    var categorySection: Section?
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var child: CategoryTableViewController?
    
    

    override func viewDidLoad() {
        

         child = (self.childViewControllers.first as? CategoryTableViewController)!
        

       child?.categorySection = self.categorySection
        
        
   
      

    }
   

    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            
            child?.releaseDateOrder()
            
       
        case 1:
            
            child?.nameOrder()
            
        
        default:
            break;
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    

}
