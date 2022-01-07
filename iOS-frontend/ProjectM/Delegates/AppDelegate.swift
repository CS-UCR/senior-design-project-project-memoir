
import ARKit

// @main tells our program here is the entry point in our program
// In our case, the AppDelegate makes sure the user's device
// supports AR before starting
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var settings: NSDictionary!
    
    // this should be converted to a shared helper function class in the future
    // converts custom key/values from Info.plt into a settings dictionary
    // ref: http://www.shannongrizzell.me/2019/12/07/using-plist-part-1-reading-plist-files/
    
    func getPropertyList(name: String) -> NSDictionary {

        // First let's get the path to our property list
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) else {
        // If the property list doesn't exist, we'll throw an error for now.
            fatalError("Unable to load the requested property list")
        }
        // With data read into the xml variable we can now decode into a dictionary object.
        let propertyDictionary = try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil) as? NSDictionary
        return propertyDictionary!
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Make sure user device supports ARWorldTrackingConfiguration
        // ARWorldTrackingConfiguration: tracks the device's position and orientation relative to
        // any surfaces, people, or known images and objects that ARKit may find and track (using rear camera).
        guard ARWorldTrackingConfiguration.isSupported else {
            // If user's device does not support, terminate app
            fatalError("Your device does not support ARKit.")
        }
        
        
        // fetch and confirm query is functioning
        Network.shared.apollo.fetch(query: TestQueryQuery()) { result in
          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
        
        // load settings dictionary from Info.plist file
        // note: you can add custom key/values by adding hardcoded variables into AppSettings.xcconfig and then adding that pair inside of Info.plist (look at the key "GraphQL URL" for an example)
        settings = getPropertyList(name: "Info");
        
        // return true if user's device supports ARWorldTracking
        return true
    }
    
}

