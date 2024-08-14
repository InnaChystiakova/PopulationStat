//
//  PopulationDetailsView.swift
//  PopulationStat
//
//  Created by Inna Chystiakova on 14/08/2024.
//

import SwiftUI

struct PopulationDetailsView: View {
    @StateObject private var viewModel = PopulationViewModel()
    let year: String
    
    var body: some View {
        List(viewModel.stateData) { data in
            VStack(alignment: .leading) {
                Text(data.state ?? "Unknown state")
                    .font(.headline)
                let populationString = String(data.population ?? 0)
                Text("Population: \(populationString)")
                    .font(.subheadline)
            }
        }
        .navigationTitle("State Data for \(year)")
        .onAppear {
            viewModel.fetchStateData(by: year)
        }
        .refreshable {
            viewModel.fetchStateData(by: year)
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

struct PopulationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PopulationDetailsView(year: "2020")
    }
}
