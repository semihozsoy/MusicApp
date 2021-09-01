//
//  MainPagePresenter.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

protocol MainPagePresentationLogic: AnyObject {
    func presentPlaylists(response: MainPage.FetchMusics.Response)
    func presentCatalogPlaylists(response: MainPage.FetchMusics.Response)
}

final class MainPagePresenter: MainPagePresentationLogic {
    
    weak var viewController: MainPageDisplayLogic?
    
    func presentPlaylists(response: MainPage.FetchMusics.Response) {
        var displayedPlaylists: [MainPage.FetchMusics.ViewModel.PlaylistsInfo] = []
        
        
        //        response.playlists?.forEach {
        //            displayedPlaylists.append(MainPage.FetchMusics.ViewModel.PlaylistsInfo(name: $0.name,
        //                                                                                   dateAdded: $0.dateAdded,
        //                                                                                   isPublic: $0.isPublic))
        //        }
        //        viewController?.displayFetchedPlaylists(viewModel: MainPage.FetchMusics.ViewModel(playlistsInfo: displayedPlaylists))
        
    }
    
    func presentCatalogPlaylists(response: MainPage.FetchMusics.Response) {
        var displayedCatalogPlaylists: [MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo] = []
    }
}
