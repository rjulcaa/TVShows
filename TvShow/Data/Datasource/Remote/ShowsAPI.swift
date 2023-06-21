//
//  ShowsAPI.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation
import Combine

struct ShowsAPIImplementation {
    private let agent = Agent()
    private let base = "https://api.tvmaze.com"
}

extension ShowsAPIImplementation: TVShowsAPI {
    func fetchTVShowsBy(search: String) -> AnyPublisher<[SearchResponse], Error> {
        return run(URLRequest(url: URL(string: base + "/search/shows?q=\(search)")!))

    }
    
    func fetchShowsBy(page: Int) -> AnyPublisher<[TVShowResponse], Error> {
        return run(URLRequest(url: URL(string: base + "/shows?page=\(page)")!))
    }
    
    func fetchEpisodesBy(showId: Int) -> AnyPublisher<[EpisodeResponse], Error> {
        return run(URLRequest(url: URL(string: base + "/shows/\(showId)/episodes")!))
    }
    
    private func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
            return agent.run(request)
                .map(\.value)
                .eraseToAnyPublisher()
    }
}
