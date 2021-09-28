//
//  PlaylistsSongs.swift
//  MusicApp
//
//  Created by Semih Özsoy on 24.08.2021.
//


import Foundation

// MARK: - PlaylistsSongs
struct CatalogPlaylists: Codable {
    let data: [CatalogPlaylistsInfo]?
}

// MARK: - PlaylistsSongsDatum
struct CatalogPlaylistsInfo: Codable {
    let id, type, href: String?
    let attributes: CatalogPlaylistsPurpleAttributes?
    let relationships: CatalogPlaylistsRelationships?
}

// MARK: - PurpleAttributes
struct CatalogPlaylistsPurpleAttributes: Codable {
    let artwork: CatalogPlaylistsArtwork?
    let isChart: Bool?
    let url: String?
    let lastModifiedDate: String?
    let name, playlistType, curatorName: String?
    let playParams: CatalogPlaylistsPlayParams?
    let attributesDescription: CatalogPlaylistsDescription?

    enum CodingKeys: String, CodingKey {
        case artwork, isChart, url, lastModifiedDate, name, playlistType, curatorName, playParams
        case attributesDescription = "description"
    }
}

// MARK: - Artwork
struct CatalogPlaylistsArtwork: Codable {
    let width, height: Int?
    let isMosaic: Bool?
    let url, bgColor, textColor1, textColor2: String?
    let textColor3, textColor4: String?
}

// MARK: - Description
struct CatalogPlaylistsDescription: Codable {
    let standard,short: String?
}

// MARK: - PlayParams
struct CatalogPlaylistsPlayParams: Codable {
    let id: String?
    let kind: String?
}


// MARK: - Relationships
struct CatalogPlaylistsRelationships: Codable {
    let tracks, curator: CatalogPlaylistsCurator?
}

// MARK: - Curator
struct CatalogPlaylistsCurator: Codable {
    let href: String?
    let data: [CatalogPlaylistsCuratorInfo]?
}

// MARK: - CuratorDatum
struct CatalogPlaylistsCuratorInfo: Codable {
    let id: String?
    let type: String?
    let href: String?
    let attributes: CatalogPlaylistsFluffyAttributes?
}

// MARK: - FluffyAttributes
struct CatalogPlaylistsFluffyAttributes: Codable { //burdaki name; song name, ayrıca albumName alsak yeterli
    let previews: [CatalogPlaylistsPreview]?
    let artwork: CatalogPlaylistsArtwork?
    let artistName: String?
    let url: String?
    let discNumber: Int?
    let genreNames: [String]?
    let durationInMillis: Int?
    let releaseDate, name, isrc: String?
    let hasLyrics: Bool?
    let albumName: String?
    let playParams: CatalogPlaylistsPlayParams?
    let trackNumber: Int?
    let composerName, contentRating: String?
}

// MARK: - Preview
struct CatalogPlaylistsPreview: Codable {
    let url: String?
}


