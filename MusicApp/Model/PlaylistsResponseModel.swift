//
//  PlaylistsResponseModel.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//


import Foundation

// MARK: - PlaylistsResponse
struct PlaylistsResponse: Codable {
    let data: [Playlists]?
    let meta: Meta?
}

// MARK: - Datum
struct Playlists: Codable {
    let id, type, href: String?
    let attributes: Attributes?
}

// MARK: - Attributes
struct Attributes: Codable {
    let dateAdded: String?
    let hasCatalog: Bool?
    let name: String?
    let attributesDescription: Description?
    let canEdit: Bool?
    let playParams: PlayParams?
    let isPublic: Bool?
    let artwork: Artwork?

    enum CodingKeys: String, CodingKey {
        case dateAdded, hasCatalog, name
        case attributesDescription = "description"
        case canEdit, playParams, isPublic, artwork
    }
}

// MARK: - Artwork
struct Artwork: Codable {
    let url: String?
}

// MARK: - Description
struct Description: Codable {
    let standard: String?
}

// MARK: - PlayParams
struct PlayParams: Codable {
    let id, kind: String?
    let isLibrary: Bool?
    let globalID: String?

    enum CodingKeys: String, CodingKey {
        case id, kind, isLibrary
        case globalID = "globalId"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let total: Int?
}

