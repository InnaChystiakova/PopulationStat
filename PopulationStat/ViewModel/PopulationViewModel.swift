//
//  PopulationViewModel.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import Foundation

class PopulationViewModel: ObservableObject {
    @Published var nationData: [NationItem] = []
    @Published var stateData: [StateItem] = []
    @Published var showErrorAlert: Bool = false
    @Published var fetching = true
    
    var errorMessage: String? = nil
    
    private let networkService = PopulationNetworkService.shared
    
    func fetchNationData() {
        networkService.fetchNationData() { [weak self] result in
            DispatchQueue.main.async {
                self?.fetching = true
                
                switch result {
                case .success(let data):
                    self?.nationData = data
                    self?.fetching = false
                case .failure(let error):
                    self?.errorMessage = error.errorDescription
                    self?.showErrorAlert = true
                    self?.fetching = false
                }
            }
        }
    }
    
    func fetchStateData(by year: String) {
        networkService.fetchStateData(by: year) { [weak self] result in
            DispatchQueue.main.async {
                self?.fetching = true
                switch result {
                case .success(let data):
                    self?.stateData = data
                    self?.fetching = false
                case .failure(let error):
                    self?.errorMessage = error.errorDescription
                    self?.showErrorAlert = true
                    self?.fetching = false
                }
            }
        }
    }
}
