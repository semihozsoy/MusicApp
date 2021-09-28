//
//  MainPageModels.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

// swiftlint:disable nesting
enum MainPage {

    enum Sections: Int {
        case search
        case playlists
        case topChart
    }
    
    enum FetchMusics {
        
        struct Request {
            var id: String?
            var searchText: String?
        }
        
        struct Response {
            var catalogPlaylists: [CatalogPlaylistsInfo]?
            var topCharts: [TopChartsResults]?
            var search: [SearchResults]?
        }
        
        struct ViewModel {
            var catalogPlaylistInfo: [MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo]?
            
            struct CatalogPlaylistsInfo {
                var albumName: String?
                var imageUrl: String?
                var songCount: Int?
            }
            
            var topChartsInfo: [MainPage.FetchMusics.ViewModel.TopChartsInfo]?
            
            struct TopChartsInfo {
                var name: String?
                var image: String?
                var playlistName: String?
            }
            var searchInfo: [MainPage.FetchMusics.ViewModel.SearchInfo]?
            
            struct SearchInfo {
                var artistName: String?
                var name: String?
            }
            
        }
        
    }
    
}
// swiftlint:enable nesting
