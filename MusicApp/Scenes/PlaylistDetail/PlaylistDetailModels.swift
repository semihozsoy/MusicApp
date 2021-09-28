//
//  PlaylistDetailModels.swift
//  MusicApp
//
//  Created by mobven semih on 1.09.2021.
//

import Foundation

// swiftlint:disable nesting
enum PlaylistDetail {
    
    enum FetchPlaylistMusic {
        
        struct Request {
            
        }
        
        struct Response {
            var catalogPlaylists: [CatalogPlaylistsInfo]?
            var albumName: String?
            var image: String?
            var songData: [CatalogPlaylistsCuratorInfo]?
        }
        
        struct ViewModel {
            
            let playlistDetailInfo: [PlaylistDetail.FetchPlaylistMusic.ViewModel.PlaylistDetailInfo]
            
            struct PlaylistDetailInfo {
                var albumName: String?
                var songName: String?
                var songImageUrl: String?
                var duration: Int?
            }
        }
        
    }
    
}
// swiftlint:enable nesting
