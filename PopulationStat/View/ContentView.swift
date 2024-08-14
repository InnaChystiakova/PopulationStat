//
//  ContentView.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PopulationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.nationData) { data in
                    VStack(alignment: .leading) {
                        NavigationLink(destination: PopulationDetailsView(year: data.year ?? "")) {
                            Text(data.year ?? "Default")
                                .font(.headline)
                            let populationString = String(data.population ?? 0)
                            Text("Population: \(populationString)")
                                .font(.subheadline)
                        }
                    }
                }
                .navigationTitle("Population Data")
                .onAppear {
                    viewModel.fetchNationData()
                }
                .refreshable {
                    viewModel.fetchNationData()
                }
                .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage ?? "An unknown error occurred"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
