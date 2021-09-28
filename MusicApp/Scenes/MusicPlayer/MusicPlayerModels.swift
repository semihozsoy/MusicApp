//
//  MusicPlayerModels.swift
//  MusicApp
//
//  Created by mobven semih on 4.09.2021.
//

import Foundation

// swiftlint:disable nesting
enum MusicPlayer {
    
    enum FetchMusic {
        
        struct Request {
            let index: Int?
        }
        
        struct Response {
            var songName: String?
            var playlistName: String?
            var image: String?
            var songUrl: String?
            var id: String?
        }
        
        struct ViewModel {
            
            let musicPlayerInfo: MusicPlayer.FetchMusic.ViewModel.MusicPlayerInfo
            
            struct MusicPlayerInfo {
                var songName: String?
                var playlistName: String?
                var songImageUrl: String?
                var songUrl: String?
                var id: String?
            }
        }
        
    }
    
}
// swiftlint:enable nesting
