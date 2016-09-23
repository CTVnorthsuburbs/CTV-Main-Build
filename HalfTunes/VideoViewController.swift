//
//  VideoViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

import UIKit

class VideoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    /*
     This value is either passed by `MyVideosViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new video.
     */
    
    var video: Video?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set up views if editing an existing Video.

        if let video = video {
            
            navigationItem.title = video.title
            
            titleLabel.text   = video.title
            
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {  //generate thumbnail in bacground

                video.generateThumbnail()
                
                DispatchQueue.main.async {

                    self.thumbnailView.image = video.thumbnail
                    
                }
                
            }
            
            thumbnailView.image = video.thumbnail
            
        }
        
        
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddVideoMode = presentingViewController is UINavigationController
        
        if isPresentingInAddVideoMode {
        
            dismiss(animated: true, completion: nil)
            
        } else {
     
            navigationController!.popViewController(animated: true)
            
        }
        
    }
    
    
    func toggleSaveButton() {
        
        
         let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: "buttonMethod")
        navigationItem.rightBarButtonItem = refreshButton
        
    }
 
}

