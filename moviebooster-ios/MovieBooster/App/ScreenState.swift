//
//  ScreenState.swift
//  MovieBooster
//
//  Created by denis on 09.08.2022.
//

import Foundation

struct ScreenState {
    
    var items = [String]()
    var searchText = ""
    var isLoading = false

    func copy(
        items: [String]? = nil,
        searchText: String? = nil,
        isLoading: Bool? = nil
    ) -> ScreenState {
        return ScreenState(
            items: items ?? self.items,
            searchText: searchText ?? self.searchText,
            isLoading: isLoading ?? self.isLoading
        )
    }
    
}
