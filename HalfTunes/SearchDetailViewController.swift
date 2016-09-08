//
//  SearchDetailViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 8/17/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit

class SearchDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    /*
     This value is either passed by `VideoTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new video.
     */
    
    var video: Video?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let video = video {
            
            navigationItem.title = video.title
            
            titleLabel.text   = video.title
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {  //generate thumbnail in background, it should check if the thumbnail is already available as a property of video.

                video.generateThumbnail()
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.thumbnailView.image = video.thumbnail
                    
                }
            }
       
            thumbnailView.image = video.thumbnail
            
        }
        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddVideoMode = presentingViewController is UINavigationController
        
        if isPresentingInAddVideoMode {
            
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            
            navigationController!.popViewControllerAnimated(true)
            
        }
        
    }

}

