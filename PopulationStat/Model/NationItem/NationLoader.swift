//
//  NationLoader.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

public enum NationFeedResult<PopulationError> {
    case success([NationItem])
    case failure(PopulationError)
}

public protocol NationLoader {
    func load(completion: @escaping (NationFeedResult<PopulationError>) -> Void)
}
