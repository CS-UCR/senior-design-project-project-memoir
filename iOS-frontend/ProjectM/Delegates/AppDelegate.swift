
import ARKit

// @main tells our program here is the entry point in our program
// In our case, the AppDelegate makes sure the user's device
// supports AR before starting
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var settings: NSDictionary!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Make sure user device supports ARWorldTrackingConfiguration
        // ARWorldTrackingConfiguration: tracks the device's position and orientation relative to
        // any surfaces, people, or known images and objects that ARKit may find and track (using rear camera).
//        guard ARWorldTrackingConfiguration.isSupported else {
//            // If user's device does not support, terminate app
//            fatalError("Your device does not support ARKit.")
//        }
        
        // return true if user's device supports ARWorldTracking
        return true
    }
    
}

