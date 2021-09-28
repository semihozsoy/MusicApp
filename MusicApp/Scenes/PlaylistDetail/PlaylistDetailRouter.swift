//
//  PlaylistDetailRouter.swift
//  MusicApp
//
//  Created by mobven semih on 1.09.2021.
//

import UIKit

protocol PlaylistDetailRoutingLogic: AnyObject {
    func routeToMusicPlayer(index: Int)
}

protocol PlaylistDetailDataPassing: AnyObject {
    var dataStore: PlaylistDetailDataStore? { get }
}

final class PlaylistDetailRouter: PlaylistDetailRoutingLogic, PlaylistDetailDataPassing {
    
    weak var viewController: PlaylistDetailViewController?
    var dataStore: PlaylistDetailDataStore?
    
    func routeToMusicPlayer(index: Int) {
        let storyBoard = UIStoryboard(name: "MusicPlayer", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "musicPlayerVC") as! MusicPlayerViewController
        destinationVC.router?.dataStore?.catalogPlaylist = dataStore?.catalogPlaylist?.relationships?.tracks?.data ?? []
        destinationVC.router?.dataStore?.selectedIndex = index
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
