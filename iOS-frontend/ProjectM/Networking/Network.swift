//
//  Network.swift
//  ProjectM
//
//  Created by Bryan on 1/5/22.
//
import Foundation
import Apollo

class Network {
  static let shared = Network()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string:ProcessInfo.processInfo.environment["graphql_url"]!)!)
}

