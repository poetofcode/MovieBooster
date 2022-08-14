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
        var copyData = screenData
        copyData.searchText = text
        screenDataSeq.accept(copyData)
        searchTextSeq.accept(text)
    }

    private func loadListsFilteredByQuery(_ searchQuery: String = "") {
        let useCase = PostUseCase(repository: PostRepository())
        
        useCase.fetchPosts(searchQuery: searchQuery) { posts in
            var copyData = self.screenDataSeq.value
            copyData.items = posts.map { $0.title }
            self.screenDataSeq.accept(copyData)
        }
    }
       
}
