//
//  ContentView.swift
//  MovieBooster
//
//  Created by denis on 03.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        List {
            if (viewModel.uiState.isLoading) {
                HStack {
                    Spacer()
                    Text("Loading...")
                    Spacer()
                }
                .listRowBackground(Color.gray.opacity(0))
            } else {
                ForEach(viewModel.uiState.items, id: \.self) { str in
                    CustomRow(content: str)
                }
            }
        }
        .navigationTitle("Names")
        .searchable(text: $viewModel.uiState.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search, {
            print("onSubmit: \(viewModel.uiState.searchText)")
        })
        .onChange(of: viewModel.uiState.searchText, perform: viewModel.onChangeSearchText)
        .onAppear(perform: viewModel.onAppear)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
