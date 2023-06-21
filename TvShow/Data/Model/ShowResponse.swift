//
//  ShowResponse.swift
//  TvShow
//
//  Created by Richard Julca Amaro on 20/06/23.
//

import Foundation

struct TVShowResponse: Codable {
    let id: Int
    let url: String
    let name: String
    let genres: [String]
    let runtime, averageRuntime: Int?
    let premiered, ended: String?
    let officialSite: String?
    let schedule: Schedule
    let rating: Rating
    let image: Image?
    let summary: String?
    let updated: Int
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id, url, name, genres, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, image, summary, updated
        case links = "_links"
    }
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: Nextepisode
    let previousepisode, nextepisode: Nextepisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

// MARK: - Nextepisode
struct Nextepisode: Codable {
    let href: String
}

enum Name: String, Codable {
    case canada = "Canada"
    case france = "France"
    case japan = "Japan"
    case unitedKingdom = "United Kingdom"
    case unitedStates = "United States"
}

enum Timezone: String, Codable {
    case americaHalifax = "America/Halifax"
    case americaNewYork = "America/New_York"
    case asiaTokyo = "Asia/Tokyo"
    case europeLondon = "Europe/London"
    case europeParis = "Europe/Paris"
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String
    let days: [Day]
}

enum Day: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}
