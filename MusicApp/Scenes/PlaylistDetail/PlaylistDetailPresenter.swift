//
//  PlaylistDetailPresenter.swift
//  MusicApp
//
//  Created by mobven semih on 1.09.2021.
//

import Foundation

protocol PlaylistDetailPresentationLogic: AnyObject {
    func presentPlaylistSongs(response: PlaylistDetail.FetchPlaylistMusic.Response)
}

final class PlaylistDetailPresenter: PlaylistDetailPresentationLogic {
    
    weak var viewController: PlaylistDetailDisplayLogic?
   
    
    func presentPlaylistSongs(response: PlaylistDetail.FetchPlaylistMusic.Response) {
        var displayPlaylistDetail: [PlaylistDetail.FetchPlaylistMusic.ViewModel.PlaylistDetailInfo] = []
        
        for item in response.songData ?? [] {
            displayPlaylistDetail.append(PlaylistDetail.FetchPlaylistMusic.ViewModel.PlaylistDetailInfo(albumName: response.albumName,
                                                                                                        songName: item.attributes?.name,
                                                                                                        songImageUrl: response.image, duration: item.attributes?.durationInMillis))
        }
       
        viewController?.displayFetchPlaylistDetail(viewModel: PlaylistDetail.FetchPlaylistMusic.ViewModel(playlistDetailInfo: displayPlaylistDetail))
    }
}
