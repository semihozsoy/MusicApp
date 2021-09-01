//
//  MainPageModels.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

// swiftlint:disable nesting
enum MainPage {

    enum FetchMusics {
        
        struct Request {
            var id: String?
        }
        
        struct Response {
            var playlists: [Playlists]?
            var catalogPlaylists: [CatalogPlaylistsFluffyAttributes]?
        }
        
        struct ViewModel {
            let playlistsInfo: [MainPage.FetchMusics.ViewModel.PlaylistsInfo]
            let catalogPlaylits: [MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo]
            
            struct PlaylistsInfo {
                var name: String?
                var dateAdded: Date?
                var isPublic: Bool?
            }
            struct CatalogPlaylistsInfo {
                var albumName: String?
                var songName: String?
            }
            
        }
        
    }
    
}
// swiftlint:enable nesting
