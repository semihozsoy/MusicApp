//
//  MusicPlayerPresenter.swift
//  MusicApp
//
//  Created by mobven semih on 4.09.2021.
//

import Foundation

protocol MusicPlayerPresentationLogic: AnyObject {
    func presentMusicPlayer(response: MusicPlayer.FetchMusic.Response)
}

final class MusicPlayerPresenter: MusicPlayerPresentationLogic {
    
    weak var viewController: MusicPlayerDisplayLogic?
    
    func presentMusicPlayer(response: MusicPlayer.FetchMusic.Response) {
       
        let model = MusicPlayer.FetchMusic.ViewModel.MusicPlayerInfo(songName: response.songName, playlistName: response.playlistName, songImageUrl: response.image,songUrl: response.songUrl)
        
        viewController?.displayFetchMusicPlayer(viewModel: MusicPlayer.FetchMusic.ViewModel(musicPlayerInfo: model))
    }
    
}
