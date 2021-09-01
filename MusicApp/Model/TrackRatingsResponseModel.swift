//
//  TrackRatingsResponseModel.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.


import Foundation

// MARK: - Welcome
struct TrackRatings: Codable {
    let data: [TrackDatum]?
}

// MARK: - Datum
struct TrackDatum: Codable {
    let id, type, href: String?
    let attributes: TrackAttributes?
}

// MARK: - Attributes
struct TrackAttributes: Codable {
    let value: Int?
}
