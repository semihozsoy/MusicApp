//
//  SearchResponseModel.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

// MARK: - Welcome
struct Search: Codable {
    let results: SearchResults?
    let meta: SearchMeta?
}

// MARK: - Meta
struct SearchMeta: Codable {
    let results: MetaResults?
}

// MARK: - MetaResults
struct MetaResults: Codable {
    let order, rawOrder: [String]?
}

// MARK: - WelcomeResults
struct SearchResults: Codable {
    let albums: Albums?
    let artists: Artists?
}

// MARK: - Albums
struct Albums: Codable {
    let href, next: String?
    let data: [AlbumsDatum]?
}

// MARK: - AlbumsDatum
struct AlbumsDatum: Codable {
    let id: String?
    let type: TypeEnum?
    let href: String?
    let attributes: SearchPurpleAttributes?
}

// MARK: - PurpleAttributes
struct SearchPurpleAttributes: Codable {
    let artwork: SearchArtwork?
    let artistName: String?
    let isSingle: Bool?
    let url: String?
    let isComplete: Bool?
    let genreNames: [String]?
    let trackCount: Int?
    let isMasteredForItunes: Bool?
    let releaseDate, name, recordLabel, upc: String?
    let copyright: String?
    let playParams: SearchPlayParams?
    let isCompilation: Bool?
    let editorialNotes: PurpleEditorialNotes?
    
    struct Request: Encodable {
        let term:String?
        init(term:String){
            self.term = term
        }
    }

}

// MARK: - Artwork
struct SearchArtwork: Codable {
    let width, height: Int?
    let url, bgColor, textColor1, textColor2: String?
    let textColor3, textColor4: String?
}

// MARK: - PurpleEditorialNotes
struct PurpleEditorialNotes: Codable {
    let standard, short: String?
}

// MARK: - PlayParams
struct SearchPlayParams: Codable {
    let id, kind: String?
}

enum TypeEnum: String, Codable {
    case albums = "albums"
}

// MARK: - Artists
struct Artists: Codable {
    let href, next: String?
    let data: [ArtistsDatum]?
}

// MARK: - ArtistsDatum
struct ArtistsDatum: Codable {
    let id, type, href: String?
    let attributes: FluffyAttributes?
    let relationships: Relationships?
}

// MARK: - FluffyAttributes
struct FluffyAttributes: Codable {
    let genreNames: [String]?
    let url: String?
    let name: String?
    let editorialNotes: FluffyEditorialNotes?
}

// MARK: - FluffyEditorialNotes
struct FluffyEditorialNotes: Codable {
    let standard: String?
}

// MARK: - Relationships
struct Relationships: Codable {
    let albums: Albums?
}


