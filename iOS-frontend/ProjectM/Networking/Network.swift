//
//  Network.swift
//  ProjectM
//
//  Created by Bryan on 1/5/22.
//
import Foundation
import Apollo

class Network {
    
    var settings: NSDictionary!
    static let shared = Network() // singleton object (no duplicate connections)
    
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
    
    init() {
        settings = getPropertyList(name: "Info")
    }
    
    private(set) lazy var apollo = ApolloClient(
        url: try! URL(jsonValue: settings["GraphQL URL"]!))
}
