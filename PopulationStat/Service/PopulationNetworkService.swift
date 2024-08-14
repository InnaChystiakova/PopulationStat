//
//  PopulationNetworkService.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

class PopulationNetworkService {
    static let shared = PopulationNetworkService()
    
    private let baseURL = "https://datausa.io/api/data"
    
    public typealias StateFetchedResult = Result<[StateItem], PopulationError>
    public typealias NationFetchedResult = Result<[NationItem], PopulationError>
        
    public func fetchNationData(completion: @escaping (NationFetchedResult) -> Void) {
        let urlString = "\(baseURL)?drilldowns=Nation&measures=Population"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let populationLoader = PopulationLoader.init(url: url, client: URLSessionHTTPClient(session: .shared))
        
        populationLoader.fetchNationData { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.invalidData))
            }
        }
    }
    
    public func fetchStateData(by year: String, completion: @escaping (StateFetchedResult) -> Void) {
        let urlString = "\(baseURL)?drilldowns=State&measures=Population&year=\(year)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let populationLoader = PopulationLoader.init(url: url, client: URLSessionHTTPClient(session: .shared))
        
        populationLoader.fetchStateData { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                completion(.failure(.invalidData))
            }
        }
    }
}
