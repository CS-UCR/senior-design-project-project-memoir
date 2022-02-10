//
//  Network.swift
//  ProjectM
//
//  Created by Bryan on 1/5/22.
//
import Foundation
import Apollo

class Network {
    
//    guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
//        throw Error.missingKey
//    }
    static let shared = Network()
    
    private(set) lazy var apollo: ApolloClient = {

        let url: String = try! Configuration.value(for: "GRAPHQL_URL")
        let api_key: String = try! Configuration.value(for: "API_KEY")
        
        let headers = [
            "x-api-key": api_key
        ]

        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let interceptorProvider = DefaultInterceptorProvider(client: client, store: store)
        let transport = RequestChainNetworkTransport(
            interceptorProvider: interceptorProvider,
            endpointURL: URL(string: "https://" + url)!,
            additionalHeaders: headers
        )
        return ApolloClient(networkTransport: transport, store: store)
        
    }()
}
