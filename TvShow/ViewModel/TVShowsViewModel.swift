//
//  TVShowsViewModel.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import Combine

class TVShowsViewModel: ObservableObject {
    
    @Published var shows: [Show] = []
    @Published var searchShowsResult: [Show] = []
    @Published var searchText: String = String()
    
    private var page : Int = 1
    
    let dataSource: TVShowsAPI
    
    var cancellable = Set<AnyCancellable>()
    init(dataSource: TVShowsAPI) {
        self.dataSource = dataSource
        $searchText.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .map({ [weak self] string in
                guard let self = self else { return }
                if string.count < 1 {
                    self.searchShowsResult = []
                    return
                }
            })
            .compactMap{ $0 }
            .sink { (_) in } receiveValue: { _ in
                self.fetchShowsBySearchQuery()
            }.store(in: &cancellable)
    }
    
    func loadMoreContent(currentItem item: Show){
        if let lastItem = self.shows.last, lastItem.id == item.id {
            page += 1
            fetchShows()
        }
    }
    
    func fetchShows() {
        dataSource.fetchShowsBy(page: page)
            .sink(receiveCompletion: { result in
            }) { [weak self] response in
                guard let self = self else { return }
                self.shows.append(contentsOf: response.map {
                    Show(id: $0.id, thumbnail: $0.image?.medium ?? "",
                         portrait: $0.image?.original ?? "", name: $0.name,
                         description: $0.summary ?? "", rating: $0.rating.average ?? 0.0,
                         genres: $0.genres, weekDaysSchedule: $0.schedule.days.map { $0.rawValue },
                         timeSchedule: $0.schedule.time)})
            }
            .store(in: &cancellable)
    }
    
    func fetchShowsBySearchQuery() {
        dataSource.fetchTVShowsBy(search: self.searchText)
            .sink { response in
                print(response)
            }
        receiveValue: { [weak self] response in
            guard let self = self else { return }
            self.searchShowsResult = response.map {
                Show(id: $0.show.id, thumbnail: $0.show.image?.medium ?? "",
                     portrait: $0.show.image?.original ?? "", name: $0.show.name,
                     description: $0.show.summary ?? "", rating: $0.show.rating.average ?? 0.0,
                     genres: $0.show.genres, weekDaysSchedule: $0.show.schedule.days.map { $0.rawValue },
                     timeSchedule: $0.show.schedule.time) }
        }
        .store(in: &cancellable)
    }
    
    
}
