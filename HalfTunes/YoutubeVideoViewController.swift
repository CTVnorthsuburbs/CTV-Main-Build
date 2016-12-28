//
//  YoutubeVideoViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 12/16/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//



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


class YoutubeVideoViewController: VideoViewController {
    
  
    
    
    func playYoutubeVideo() {
        
        
        
        
        
        
        let webView = UIWebView(frame: self.view.frame)
        
        self.view.addSubview(webView)
        self.view.bringSubview(toFront: webView)
        
        webView.allowsInlineMediaPlayback = true
        webView.mediaPlaybackRequiresUserAction = false
        
        var videoID = ""
        
        
        videoID = (video?.sourceUrl)!     // https://www.youtube.com/watch?v=28myxjncnDM     http://www.youtube.com/embed/28myxjncnDM
        
        let embededHTML = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(self.view.frame.size.width)' height='\(self.view.frame.size.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
        
        
        
        
        
        
        webView.loadHTMLString(embededHTML, baseURL: Bundle.main.resourceURL)
        
        

        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
}















