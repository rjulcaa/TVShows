//
//  EpisodeResponse.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation


// MARK: - Welcome4Element
struct EpisodeResponse: Codable {
    let id: Int
    let url: String?
    let name: String?
    let season, number: Int
    let airdate, airtime: String?
    let airstamp: String?
    let runtime: Int
    let rating: Rating?
    let image: Image?
    let summary: String?
    let links: Links?
}
