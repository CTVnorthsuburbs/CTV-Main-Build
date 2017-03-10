//
//  LoadingOverlay.swift
//  HalfTunes
//
//  Created by William Ogura on 1/5/17.
//
//

import Foundation
import UIKit


/*  Usage

LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)


DispatchQueue.global(qos: .userInitiated).async {
 
 
 
 //Do the main task here
 
 
    DispatchQueue.main.async( execute: {
        
        LoadingOverlay.shared.hideOverlayView()
    })
    
 */

public class LoadingOverlay{
    
    var overlayView = UIView()
    
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        
        struct Static {
            
            static let instance: LoadingOverlay = LoadingOverlay()
            
        }
        
        return Static.instance
        
    }
    
    public func showOverlay(view: UIView!) {
        
        overlayView = UIView(frame: UIScreen.main.bounds)
        
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        activityIndicator.center = overlayView.center
        
        overlayView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        view.addSubview(overlayView)
        
    }
    
    public func hideOverlayView() {
        
        activityIndicator.stopAnimating()
        
        overlayView.removeFromSuperview()
        
    }
    
}
