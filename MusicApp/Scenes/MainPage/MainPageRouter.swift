//
//  MainPageRouter.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import UIKit

protocol MainPageRoutingLogic: AnyObject {
    func routeToPlaylistDetail(index: Int)
}

protocol MainPageDataPassing: AnyObject {
    var dataStore: MainPageDataStore? { get }
}

final class MainPageRouter: MainPageRoutingLogic, MainPageDataPassing {
    weak var viewController: MainPageViewController?
    var dataStore: MainPageDataStore?
    
    func routeToPlaylistDetail(index: Int) {
        let storyBoard = UIStoryboard(name: "PlaylistDetail", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "PlaylistDetailVC") as! PlaylistDetailViewController
        destinationVC.router?.dataStore?.catalogPlaylist = dataStore?.catalogPlaylists?[index]
        self.viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

