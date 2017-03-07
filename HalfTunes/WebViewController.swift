//
//  WebViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 12/14/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    @IBOutlet weak var webView: UIWebView!
    
    var url: URL?
   
    
 /*
    @IBAction func backAction(sender: AnyObject) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardAction(sender: AnyObject) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
 */
    


  
    
    
    @IBAction func refreshAction(sender: AnyObject) {
        webView.reload()
    }
    
  
    
    func setTitle(title: String) {
        
        navigationTitle.title = title
        
    }
    
    func setPage(url: URL) {
        
        
        
        self.url = url
        
      //  webView.reload()
    }
    

    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
       // parentVC = self.parent
        
        
        
        
        if(url != nil) {
        
        webView.loadRequest(NSURLRequest(url: url!) as URLRequest)
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
