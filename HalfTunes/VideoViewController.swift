//
//  VideoViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 7/15/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation
import MediaPlayer
import UIKit

import AVFoundation
import AVKit


class VideoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var thumbnailButton: UIButton!
    
       var moviePlayer : AVPlayer?

    /*
     This value is either passed by `MyVideosViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new video.
     */
    
    var video: Video?
    
 
    
        
        
    

  
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        
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
    

    @IBAction func playVideo(_ sender: AnyObject) {

        
        let videoPath = Bundle.main.path(forResource: video?.sourceUrl, ofType:"mp4")
        
        //Make a URL from your path
        
        //Initalize the movie player
        
        if (!localFileExistsForVideo(video!)) {
            
            if let urlString = video?.sourceUrl, let url = localFilePathForUrl(urlString) {
                
                let fileUrl = URL(string: urlString)
                
                  let moviePlayer:AVPlayer! = AVPlayer(url: fileUrl!)
                
                
                let playerViewController = AVPlayerViewController()
                playerViewController.player = moviePlayer
                
                
              
                
               // presentMoviePlayerViewControllerAnimated(moviePlayer)
                
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                
            }
            
        } else {
            print("local file exists for: \(video?.title)")
            playDownload(video!)
            
        }

        
        
        
        
    }
    
    
    
    func playDownload(_ video: Video) {
        
        if let urlString = video.sourceUrl, let url = localFilePathForUrl(urlString) {
            
         
            
            
          
            
            let moviePlayer:AVPlayer! = AVPlayer(url: url)
            
            
            let playerViewController = AVPlayerViewController()
            playerViewController.player = moviePlayer
            
            
            
            
            // presentMoviePlayerViewControllerAnimated(moviePlayer)
            
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }

        }
        
    }
    
    // MARK: Download helper methods
    
    // This method generates a permanent local file path to save a track to by appending
    // the lastPathComponent of the URL (i.e. the file name and extension of the file)
    // to the path of the app’s Documents directory.
    
    func localFilePathForUrl(_ previewUrl: String) -> URL? {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        
        let url = URL(string: previewUrl)
        
        
        let lastPathComponent = url?.lastPathComponent
        
        let fullPath = documentsPath.appendingPathComponent(lastPathComponent!)
        
        return URL(fileURLWithPath:fullPath)
        
        
        
        //return nil
        
    }
    
    // This method checks if the local file exists at the path generated by localFilePathForUrl(_:)
    
    func localFileExistsForVideo(_ video: Video) -> Bool {
        
        if let urlString = video.sourceUrl, let localUrl = localFilePathForUrl(urlString) {
            
            var isDir : ObjCBool = false
            
            let path = localUrl.path
            
            return FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
            
            
            
        }
        
        return false
        
    }

    
    func toggleSaveButton() {
        
        
         let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: "buttonMethod")
        navigationItem.rightBarButtonItem = refreshButton
        
    }
 
}

