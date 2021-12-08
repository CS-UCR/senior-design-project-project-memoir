//
//  AppDelegate.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/1/21.
//

import ARKit

// @main tells our program here is the entry point in our program
// In our case, the AppDelegate makes sure the user's device
// supports AR before starting
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Make sure user device supports ARWorldTrackingConfiguration
        // ARWorldTrackingConfiguration: tracks the device's position and orientation relative to
        // any surfaces, people, or known images and objects that ARKit may find and track (using rear camera).
        guard ARWorldTrackingConfiguration.isSupported else {
            // If user's device does not support, terminate app
            fatalError("Your device does not support ARKit.")
        }
        // return true if user's device supports ARWorldTracking
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}
