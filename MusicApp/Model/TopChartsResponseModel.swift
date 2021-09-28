//
//  TopChartsResponseModel.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.

import Foundation

// MARK: - TopCharts
struct TopCharts: Codable {
    let results: TopChartsResults?
    let meta: TopChartsMeta?
}

// MARK: - Meta
struct TopChartsMeta: Codable {
    let results: TopChartsMetaResults?
}

// MARK: - MetaResults
struct TopChartsMetaResults: Codable {
    let order: [String]?
}

// MARK: - TopChartsResults
struct TopChartsResults: Codable {
    let songs, playlists, albums: [TopChartsAlbum]?
}

// MARK: - Album
struct TopChartsAlbum: Codable {
    let chart, name, orderID, next: String?
    let data: [TopChartsDatum]?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case chart, name
        case orderID = "orderId"
        case next, data, href
    }
}

// MARK: - Datum
struct TopChartsDatum: Codable {
    let id, type, href: String?
    let attributes: TopChartsAttributes?
}

// MARK: - Attributes
struct TopChartsAttributes: Codable {
    let artwork: TopChartsArtwork?
    let artistName: String?
    let isSingle: Bool?
    let url: String?
    let isComplete: Bool?
    let genreNames: [String]?
    let trackCount: Int?
    let isMasteredForItunes: Bool?
    let releaseDate, name, recordLabel, upc: String?
    let copyright: String?
    let playParams: TopChartsPlayParams?
    let editorialNotes: EditorialNotes?
    let isCompilation: Bool?
    let contentRating: String?
    let previews: [Preview]?
    let discNumber, durationInMillis: Int?
    let isrc: String?
    let hasLyrics: Bool?
    let albumName: String?
    let trackNumber: Int?
    let composerName: String?
}

// MARK: - Artwork
struct TopChartsArtwork: Codable {
    let width, height: Int?
    let url, bgColor, textColor1, textColor2: String?
    let textColor3, textColor4: String?
}

// MARK: - EditorialNotes
struct EditorialNotes: Codable {
    let standard, short: String?
}

// MARK: - PlayParams
struct TopChartsPlayParams: Codable {
    let id, kind: String?
}

// MARK: - Preview
struct Preview: Codable {
    let url: String?
}
