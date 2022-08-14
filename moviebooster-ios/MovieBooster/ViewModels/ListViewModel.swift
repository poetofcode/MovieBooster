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
    @Published var screenData = ScreenData()
    
    private let repository: Repository
    private let disposeBag = DisposeBag()
    private let screenDataSeq = BehaviorRelay(value: ScreenData())
    private let searchTextSeq = BehaviorRelay(value: "")
    
    init(repository: Repository) {
        self.repository = repository
        
        screenDataSeq.subscribe { [weak self] value in
            self?.screenData = value
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
        screenDataSeq.accept(screenDataSeq.value.copy(searchText: text))
        searchTextSeq.accept(text)
    }

    private func loadListsFilteredByQuery(_ searchQuery: String = "") {
        let useCase = PostUseCase(repository: PostRepository())
        
        useCase.fetchPosts(searchQuery: searchQuery) { posts in
            self.screenDataSeq.accept(self.screenDataSeq.value.copy(items: posts.map { $0.title }))
        }
    }
       
}
