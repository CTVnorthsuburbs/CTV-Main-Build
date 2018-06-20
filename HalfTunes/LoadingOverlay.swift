//
//  LoadingOverlay.swift
//  HalfTunes
//
//  Created by William Ogura on 1/5/17.
//
// Charlie Rooney Updated June 20th 2018
//
/*Copyright (c) 2017 Vortex Software (http://www.vortexsoftware.com.ar)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.*/

import Foundation
import UIKit


public class LoadingOverlay
{
    static var overlayBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    static var activityIndicatorStyle = UIActivityIndicatorViewStyle.whiteLarge
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay
    {
        struct Static {static let instance: LoadingOverlay = LoadingOverlay()}
        return Static.instance
    }
    
    public func show(over view: UIView!)
    {
        hide()
        
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = LoadingOverlay.overlayBackgroundColor
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: LoadingOverlay.activityIndicatorStyle)
        activityIndicator.center = overlayView.center
        
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }
    
    public func hide()
    {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    public func showOverlay(view: UIView!) { // Deprecated
        show(over: view)
    }
    
    public func hideOverlayView() { // Deprecated
        hide()
    }
}//loading Overlay

extension UIViewController { // + LoadingOverlay
    
    func showLoadingOverlayOnlyInView(){
        LoadingOverlay.shared.show(over: self.view)
    }
    
    func showLoadingOverlay(){
        showLoadingOverlayOnlyInView()
    }
    
    func showLoadingOverlay(coveringNavigationBar overNavigation: Bool){
        if overNavigation {
            if let navigationController = self.navigationController{
                LoadingOverlay.shared.show(over: navigationController.view)
            }else{
                showLoadingOverlayOnlyInView()
            }
        }else{
            showLoadingOverlayOnlyInView()
        }
    }
    
    func showLoadingOverlay(withTimeout timeout: Int){
        showLoadingOverlay()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeout), execute: {
            self.hideLoadingOverlay()
        })
    }
    
    func showLoadingOverlay(withTimeout timeout: Int, coveringNavigationBar overNavigation: Bool){
        showLoadingOverlay(coveringNavigationBar: overNavigation)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeout), execute: {
            self.hideLoadingOverlay()
        })
    }
    
    func toggleLoadingOverlay(_ enabled: Bool){
        if enabled{
            showLoadingOverlay()
        }else{
            hideLoadingOverlay()
        }
    }
    
    func toggleLoadingOverlay(_ enabled: Bool, coveringNavigationBar overNavigation: Bool){
        if enabled{
            if overNavigation {
                showLoadingOverlay(coveringNavigationBar: overNavigation)
            }else{
                showLoadingOverlay()
            }
            
        }else{
            hideLoadingOverlay()
        }
    }
    
    func hideLoadingOverlay(){
        LoadingOverlay.shared.hideOverlayView()
    }
}//extension
