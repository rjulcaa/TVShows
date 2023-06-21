//
//  Show.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import SwiftUI

struct Show: Identifiable {
    let id: Int
    let thumbnail: String
    let portrait: String
    let name: String
    var description: String
    let rating: Double
    let genres: [String]
    let weekDaysSchedule: [String]
    let timeSchedule: String
}

struct Season: Identifiable {
    let id = UUID()
    let number: Int
    let episodes: [Episode]
}


struct Episode: Identifiable {
    let id: Int
    let name: String
    let number: Int
    let season: Int
    let summary: String
    let thumbnail: String
    let portrait: String
}
