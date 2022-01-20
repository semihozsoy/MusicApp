//
//  MusicPlayerInteractor.swift
//  MusicApp
//
//  Created by mobven semih on 4.09.2021.
//

import UIKit
import AVFoundation

protocol MusicPlayerBusinessLogic: AnyObject {
    func fetchMusic(request: MusicPlayer.FetchMusic.Request)
    func changeMusic(index: Int)
    
}

protocol MusicPlayerDataStore: AnyObject {
    var catalogPlaylist: [CatalogPlaylistsCuratorInfo] {get set}
    var selectedIndex: Int {get set}
}

final class MusicPlayerInteractor: MusicPlayerBusinessLogic, MusicPlayerDataStore {
    var catalogPlaylist: [CatalogPlaylistsCuratorInfo] = []
    var presenter: MusicPlayerPresentationLogic?
    var worker: MusicPlayerWorkingLogic?
    var selectedIndex: Int = 0

    
    init(worker: MusicPlayerWorkingLogic) {
        self.worker = worker
    }

    func fetchMusic(request: MusicPlayer.FetchMusic.Request) {
        
        selectedIndex = request.index == nil ? selectedIndex : request.index ?? 0
    
        guard catalogPlaylist.count > selectedIndex else { return }
        let item = catalogPlaylist[safe:selectedIndex]
       
        self.presenter?.presentMusicPlayer(response: MusicPlayer.FetchMusic.Response(songName: item?.attributes?.name,
                                                                                     playlistName: item?.attributes?.albumName,
                                                                                     image: item?.attributes?.artwork?.url,
                                                                                     songUrl: item?.attributes?.previews?.first?.url))
    }
    
    func changeMusic(index: Int) {
        selectedIndex += index
        fetchMusic(request: MusicPlayer.FetchMusic.Request(index: selectedIndex))
    }
    
    
    
    
}
