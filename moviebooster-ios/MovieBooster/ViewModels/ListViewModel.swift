//
//  MyViewModel.swift
//  MovieBooster
//
//  Created by denis on 08.08.2022.
//

import Foundation
import SwiftUI
import RxSwift
import RxRelay
import kmmshared

class ListViewModel : ObservableObject {
    @Published var uiState = ScreenState()
    
    private let useCase = PostUseCase(repository: PostRepository())
    private let disposeBag = DisposeBag()
    private let rxState = BehaviorRelay(value: ScreenState())
    private let searchTextSeq = BehaviorRelay(value: "")
    
    private var currState: ScreenState { rxState.value }
    private var searchRunning = false
    
    init() {
        rxState.subscribe { [weak self] value in
            self?.uiState = value
        }
        .disposed(by: disposeBag)
        
        searchTextSeq
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map({ queryText in
                queryText.trimming()
            })
            .subscribe(onNext: { [weak self] text in
                guard let self = self else {return}
                self.loadListsFilteredByQuery(text)
            })
            .disposed(by: disposeBag)
        
    }

    func onAppear() {
        loadListsFilteredByQuery()
    }
    
    func onChangeSearchText(text: String) {
        print(#function + ": \(text)")
        rxState.accept(rxState.value.copy(searchText: text))
        searchTextSeq.accept(text)
    }

    private func loadListsFilteredByQuery(_ searchQuery: String = "") {
        rxState.accept(currState.copy(isLoading: true))
        
        useCase.fetchPosts(searchQuery: searchQuery) { posts in
            self.rxState.accept(self.currState.copy(
                items: posts.map { $0.title },
                isLoading: false
            ))
        }
    }
      
}
