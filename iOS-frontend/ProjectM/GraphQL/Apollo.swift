//
//  Apollo.swift
//  ProjectM
//
//  Created by Bryan on 11/21/21.
//

import Foundation
import Apollo


class Network {
    static let shared = Network()
    let graphUrl = ProcessInfo.processInfo.environment["graphql_url"]
    let graphApiKey = ProcessInfo.processInfo.environment["graphql_api_key"]
//  WIP(bryan)
    private(set) lazy var apollo: ApolloClient = {
         // The cache is necessary to set up the store, which we're going to hand to the provider
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)

        let client = URLSessionClient()
        let provider = DefaultInterceptorProvider(store: store)
        let url = URL(string: graphUrl!)!
        let headers = [
            "x-api-key": graphApiKey!
        ]

        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url, additionalHeaders: headers)


         // Remember to give the store you already created to the client so it
         // doesn't create one on its own
         return ApolloClient(networkTransport: requestChainTransport,
                             store: store)
     }()
    
    
}
