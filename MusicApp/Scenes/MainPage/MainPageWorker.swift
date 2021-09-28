//
//  MainPageWorker.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

protocol MainPageWorkingLogic: AnyObject {
    func fetchPlaylists(completion:@escaping ((Result<PlaylistsResponse,Error>)->Void))
    func fetchCatalogPlaylists(id:String,completion:@escaping ((Result<CatalogPlaylists,Error>)->Void))
    func fetchTopChart(completion: @escaping ((Result< TopCharts,Error>) -> Void))
    func fetchSearch(request: SearchPurpleAttributes.Request , completion: @escaping ((Result<Search,Error>)->Void))
}

final class MainPageWorker: MainPageWorkingLogic {

    let networkManager: NetworkManager<MusicEndpointItem> = NetworkManager()

    func fetchPlaylists(completion: @escaping ((Result<PlaylistsResponse, Error>) -> Void)) {
        networkManager.request(endpoint: .playlists, type: PlaylistsResponse.self, completion: completion)
    }
    
    func fetchTopChart(completion: @escaping ((Result<TopCharts, Error>) -> Void)) {
        networkManager.request(endpoint: .topCharts, type: TopCharts.self, completion: completion)
    }
    
    func fetchCatalogPlaylists(id: String, completion: @escaping ((Result<CatalogPlaylists, Error>) -> Void)) {
        networkManager.request(endpoint: .catalogPlaylists(id: id), type: CatalogPlaylists.self, completion: completion)
    }
    func fetchSearch(request: SearchPurpleAttributes.Request, completion: @escaping ((Result<Search, Error>) -> Void)) {
        networkManager.request(endpoint: .search(queryParams: request.term ?? ""), type: Search.self, completion: completion)
    }
    

    
}
