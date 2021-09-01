//
//  MainPageInteractor.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

protocol MainPageBusinessLogic: AnyObject {
    func fetchPlaylists(request:MainPage.FetchMusics.Request)
    func fetchCatalogPlaylists(request:MainPage.FetchMusics.Request)
}

protocol MainPageDataStore: AnyObject {
    var playlists: [Playlists]? {get}
    var id: PlayParams? {get}
    var catalogPlaylists: [CatalogPlaylistsFluffyAttributes]? {get}
}

final class MainPageInteractor: MainPageBusinessLogic, MainPageDataStore {
    var catalogPlaylists: [CatalogPlaylistsFluffyAttributes]?
    var id: PlayParams?
    var playlists: [Playlists]? = []
    var presenter: MainPagePresentationLogic?
    var worker: MainPageWorkingLogic?
    
    init(worker: MainPageWorkingLogic) {
        self.worker = worker
    }
    func fetchPlaylists(request: MainPage.FetchMusics.Request) {
        worker?.fetchPlaylists(completion: { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.playlists = response.data
                self.worker?.fetchCatalogPlaylists(id: self.playlists?[1].attributes?.playParams?.globalID ?? "", completion: { [weak self] result in
                    switch result {
                    case let .success(response):
                        self?.catalogPlaylists = response.attributes
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                })
                self.presenter?.presentPlaylists(response: .init(playlists: self.playlists))
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchCatalogPlaylists(request: MainPage.FetchMusics.Request) {
        worker?.fetchCatalogPlaylists(id: id?.globalID ?? "", completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.catalogPlaylists = response.attributes
                //self?.presenter?.presentPlaylists(response: .init(playlists: self?.playlists, catalogPlaylists: self?.catalogPlaylists))
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}
