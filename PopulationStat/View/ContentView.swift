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
                List{
                    ForEach($viewModel.nationData, id: \.self) { $data in
                        NavigationLink(destination: PopulationDetailsView(year: data.year ?? "")) {
                            Text(data.year ?? "Default")
                                .font(.headline)
                            let populationString = String(data.population ?? 0)
                            Text("Population: \(populationString)")
                                .font(.subheadline)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .overlay {
                    if (viewModel.fetching) {
                        ProgressView("Fetching data, please wait...")
                            .progressViewStyle(
                                CircularProgressViewStyle(tint: .accentColor)
                            )
                    }
                }
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
                .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea())
                .navigationTitle("Population Data")
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.automatic)
                .tint(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
