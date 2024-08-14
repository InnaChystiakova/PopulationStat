//
//  PopulationError.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

public enum PopulationError: Swift.Error {
    case connectivity
    case invalidData
    case invalidURL
}

extension PopulationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectivity:
            return NSLocalizedString("Connectivity issue. Please check your internet connection.", comment: "")
        case .invalidData:
            return NSLocalizedString("Received invalid data. Please try again later.", comment: "")
        case .invalidURL:
            return NSLocalizedString("Invalid URL. Please contact support.", comment: "")
        }
    }
}
