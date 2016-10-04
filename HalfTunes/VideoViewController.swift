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
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var thumbnailButton: UIButton!
    
    @IBOutlet weak var addVideoButton: UIButton!
    
    var moviePlayer : AVPlayer?
    
    var video: Video?
    
    var myVideos = [Video]()
    
    override func viewDidLoad() {
        
        
        addVideoButton.setTitle("Download", for: UIControlState.selected)
        
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
        
        myVideos = loadVideos()!
        
        if (hasSavedVideo()) {
            
            
            toggleAddButton()
        }

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
            myVideos = loadVideos()!
        
            toggleAddButton()
        
    
    }
    
    
    func loadVideos() -> [Video]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
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
    

    @IBAction func addVideo(_ sender: AnyObject) {
        
        
        if(!addVideoButton.isSelected) {
        saveVideos()
        }
    }
    
    func hasSavedVideo() -> Bool {
        
        for vid in myVideos {
            
            if (vid.title == video?.title) {
                
                return true
            }
            
        }

        
        return false
    }
    
    func saveVideos() {
        
        
        myVideos.append(video!)
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myVideos, toFile: Video.ArchiveURL.path)
        print("saved the video")
        
        if (isSuccessfulSave) {
            
            toggleAddButton()
        } else {
 
            print("Failed to save videos...")
            
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
    
    func toggleAddButton() {
    
        
        if(localFileExistsForVideo(video!)) {
      
             addVideoButton.setTitle("Downloaded", for: UIControlState.selected)
            
            
            addVideoButton.isSelected = true
            
        } else {
        
        
        if(hasSavedVideo()) {
        addVideoButton.setTitle("Download", for: UIControlState.selected)
addVideoButton.isSelected = true
            
        } else {
            
            addVideoButton.setTitle("+ Add", for: UIControlState.normal)

            addVideoButton.isSelected = false
        }
        
    }
    }
    
}

