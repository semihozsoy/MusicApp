//
//  PlaylistDetailInteractor.swift
//  MusicApp
//
//  Created by mobven semih on 1.09.2021.
//

import Foundation

protocol PlaylistDetailBusinessLogic: AnyObject {
    func  fetchPlaylistDetail(request: PlaylistDetail.FetchPlaylistMusic.Request)
}

protocol PlaylistDetailDataStore: AnyObject {
    var catalogPlaylist: CatalogPlaylistsInfo? {get set}
}

final class PlaylistDetailInteractor: PlaylistDetailBusinessLogic, PlaylistDetailDataStore {
    var catalogPlaylist: CatalogPlaylistsInfo?
    var presenter: PlaylistDetailPresentationLogic?
    var worker: PlaylistDetailWorkingLogic?
    
    init(worker: PlaylistDetailWorkingLogic) {
        self.worker = worker
    }
    
    func fetchPlaylistDetail(request: PlaylistDetail.FetchPlaylistMusic.Request) {

      self.presenter?.presentPlaylistSongs(response: PlaylistDetail.FetchPlaylistMusic.Response(albumName: catalogPlaylist?.attributes?.name, image: catalogPlaylist?.attributes?.artwork?.url, songData: catalogPlaylist?.relationships?.tracks?.data))
    }
}
