//
//  PopulationLoader.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

public final class PopulationLoader {
    private let url: URL
    private let client: URLSessionHTTPClient
        
    public init(url:URL, client: URLSessionHTTPClient) {
        self.client = client
        self.url = url
    }
    
    public typealias StateResult = StateFeedResult<PopulationError>
    public typealias NationResult = NationFeedResult<PopulationError>
    
    public func fetchNationData(completion: @escaping (NationResult) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                completion(NationItemMapper.map(data, from: response))
            case .failure:
                completion(.failure(PopulationError.connectivity))
            }
        }
    }
    
    public func fetchStateData(completion: @escaping (StateResult) -> Void) {
        client.get(from: url) { result in            
            switch result {
            case let .success(data, response):
                completion(StateItemMapper.map(data, from: response))
            case .failure:
                completion(.failure(PopulationError.connectivity))
            }
        }
    }
    
}
