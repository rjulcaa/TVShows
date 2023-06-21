//
//  ShowsContract.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import Combine

protocol TVShowsAPI {
    func fetchShowsBy(page: Int) -> AnyPublisher<[TVShowResponse], Error>
    func fetchEpisodesBy(showId: Int) -> AnyPublisher<[EpisodeResponse], Error>
    func fetchTVShowsBy(search: String) -> AnyPublisher<[SearchResponse], Error>
    
}
