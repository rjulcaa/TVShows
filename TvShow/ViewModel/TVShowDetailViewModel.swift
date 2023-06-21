//
//  TVShowDetailViewModel.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import Combine

class TVShowDetailViewModel: ObservableObject {
    
    @Published var show: Show
    let dataSource: TVShowsAPI
    @Published var seasons: Int = 0
    
    @Published var episodePerSeason: [Int: [Episode]] = [:]
    @Published var selectedSeason: Int = 0

    var cancellable = Set<AnyCancellable>()
    var episodesLoaded = false
    
    init(show: Show,
         dataSource: TVShowsAPI) {
        self.show = show
        self.dataSource = dataSource
    }
    
    func fetchEpisodes() {
        guard !episodesLoaded else { return }
        dataSource.fetchEpisodesBy(showId: show.id)
            .sink(receiveCompletion: { repse in
                print(repse)
            },
                  receiveValue: { [weak self] response in
                guard let self = self else { return }
                response.forEach { episodeResponse in
                    let episode = Episode(id: episodeResponse.id,
                                          name: episodeResponse.name ?? "",
                                          number: episodeResponse.number,
                                          season: episodeResponse.season,
                                          summary: episodeResponse.summary ?? "",
                                          thumbnail: episodeResponse.image?.medium ?? "",
                                          portrait: episodeResponse.image?.original ?? "")
                    if self.episodePerSeason[episodeResponse.season] != nil {
                        self.episodePerSeason[episodeResponse.season]! += [episode]
                    } else {
                        self.episodePerSeason.updateValue([episode], forKey: episodeResponse.season)
                    }
                    
                }
                self.seasons = self.episodePerSeason.keys.count
                self.selectedSeason = 1
                self.episodesLoaded = true
            })
            .store(in: &cancellable)
    }
    
}
