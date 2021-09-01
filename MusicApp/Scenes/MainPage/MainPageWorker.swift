//
//  MainPageWorker.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

protocol MainPageWorkingLogic: AnyObject {
    func fetchPlaylists(completion:@escaping ((Result<PlaylistsResponse,Error>)->Void))
    func fetchCatalogPlaylists(id:String,completion:@escaping ((Result<CatalogPlaylistsCuratorInfo,Error>)->Void))
    func fetchSearch(request: SearchPurpleAttributes.Request , completion: @escaping ((Result<Playlists,Error>)->Void))
}

final class MainPageWorker: MainPageWorkingLogic {

    let networkManager: NetworkManager<MusicEndpointItem> = NetworkManager()

    func fetchPlaylists(completion: @escaping ((Result<PlaylistsResponse, Error>) -> Void)) {
        networkManager.request(endpoint: .playlists, type: PlaylistsResponse.self, completion: completion)
    }
    
    func fetchCatalogPlaylists(id: String, completion: @escaping ((Result<CatalogPlaylistsCuratorInfo, Error>) -> Void)) {
        networkManager.request(endpoint: .catalogPlaylists(id: id), type: CatalogPlaylistsCuratorInfo.self, completion: completion)
    }
    func fetchSearch(request: SearchPurpleAttributes.Request, completion: @escaping ((Result<Playlists, Error>) -> Void)) {
        
    }
    
}
