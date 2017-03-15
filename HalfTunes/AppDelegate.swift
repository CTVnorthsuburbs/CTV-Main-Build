 //
 //  AppDelegate.swift
 //  HalfTunes
 //
 //
 // 
 //
 
 import UIKit
 
 import CoreData
 
 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var backgroundSessionCompletionHandler: (() -> Void)?
    var window: UIWindow?
    let tintColor =  UIColor(red: 36/255, green: 81/255, blue: 186/255, alpha: 1)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
          NotificationCenter.default.post(name: NSNotification.Name.UIApplicationWillEnterForeground, object:nil)
        
        customizeAppearance()
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        backgroundSessionCompletionHandler = completionHandler
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    

    
    
   
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
        
     
        
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
       // NotificationCenter.default.post(name: NSNotification.Name.UIApplicationDidBecomeActive, object:nil)
       
        
   
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
      //  self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "testing.coredata" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
  
    
    
   

    
    
    var shouldRotate = false
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if shouldRotate {
            return .allButUpsideDown
        }
        else {
            return .portrait
        }
    }
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        guard let vc = (window?.rootViewController?.presentedViewController) else {
            return .portrait
        }
       
        if (vc.isKind(of: NSClassFromString("AVFullScreenViewController")!)) {
            return .allButUpsideDown
        }
        
        return .portrait
    }

    
    // MARK - App Theme Customization
    
    fileprivate func customizeAppearance() {
        window?.tintColor = tintColor
      //  UISearchBar.appearance().barTintColor = tintColor
       // UINavigationBar.appearance().barTintColor = tintColor
       // UINavigationBar.appearance().tintColor = UIColor.white
       // UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
    
    
    
    
    

       
    
 }
 

    

