//
//  PopulationLoader.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

public enum PopulationLoaderResult {
    case nationResult(NationResult)
    case stateResult(StateResult)
}

public final class PopulationLoader {
    private let url: URL
    private let client: URLSessionHTTPClient
        
    public init(url:URL, client: URLSessionHTTPClient) {
        self.client = client
        self.url = url
    }
    
    public func fetchNationData(completion: @escaping (PopulationLoaderResult) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                completion(.nationResult(NationItemMapper.map(data, from: response)))
            case .failure:
                completion(.nationResult(.failure(PopulationError.connectivity)))
            }
        }
    }
    
    public func fetchStateData(completion: @escaping (PopulationLoaderResult) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                completion(.stateResult(StateItemMapper.map(data, from: response)))
            case .failure:
                completion(.stateResult(.failure(PopulationError.connectivity)))
            }
        }
    }
    
}
