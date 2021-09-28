//
//  MainPagePresenter.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
// Copyright © 2021 Semih Özsoy. All rights reserved.

import Foundation

protocol MainPagePresentationLogic: AnyObject {
    func presentPlaylists(response: MainPage.FetchMusics.Response)
    func presentTopCharts(response: MainPage.FetchMusics.Response)
}

final class MainPagePresenter: MainPagePresentationLogic {
    
    weak var viewController: MainPageDisplayLogic?
    
    func presentPlaylists(response: MainPage.FetchMusics.Response) {
        var displayedCatalogPlaylists: [MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo] = []
        var displayedSearch: [MainPage.FetchMusics.ViewModel.SearchInfo] = []

        response.catalogPlaylists?.forEach{
            displayedCatalogPlaylists.append(MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo(albumName: $0.attributes?.name, imageUrl: $0.attributes?.artwork?.url,songCount: $0.relationships?.tracks?.data?.count))
        }
        
        for item in response.search ?? [] {
            for searchItem in item.albums?.data ?? [] {
                displayedSearch.append(MainPage.FetchMusics.ViewModel.SearchInfo(artistName: searchItem.attributes?.artistName , name: searchItem.attributes?.name))
            }
        }
    
        viewController?.displayFetchedPlaylists(viewModel: MainPage.FetchMusics.ViewModel(catalogPlaylistInfo: displayedCatalogPlaylists,searchInfo: displayedSearch))
        
    }
    
    func presentTopCharts(response: MainPage.FetchMusics.Response) {
        var displayedTopCharts: [MainPage.FetchMusics.ViewModel.TopChartsInfo] = []
        for item in response.topCharts?.first?.songs?.first?.data ?? [] {
            displayedTopCharts.append(MainPage.FetchMusics.ViewModel.TopChartsInfo(name: item.attributes?.name, image: item.attributes?.artwork?.url, playlistName: item.attributes?.artistName))
        }
        
        viewController?.displayTopCharts(viewModel: MainPage.FetchMusics.ViewModel(topChartsInfo: displayedTopCharts))
    }
    
}



