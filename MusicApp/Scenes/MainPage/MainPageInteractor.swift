//
//  MainPageInteractor.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

protocol MainPageBusinessLogic: AnyObject {
    func fetchPlaylists(request:MainPage.FetchMusics.Request)
    func fetchCatalogPlaylists(with playlists: [Playlists])
    func fetchTopCharts(request:MainPage.FetchMusics.Request)
    func fetchSearch(request: MainPage.FetchMusics.Request)
    func fetchFilterTopCharts(request: MainPage.FetchMusics.Request)
}

protocol MainPageDataStore: AnyObject {
    var catalogPlaylists: [CatalogPlaylistsInfo]? {get}
}

final class MainPageInteractor: MainPageBusinessLogic, MainPageDataStore {
    var catalogPlaylists: [CatalogPlaylistsInfo]? = []
    var playlists: [Playlists]? = []
    var searchPlaylists: [SearchResults]? = []
    var topCharts: [TopChartsResults]? = []
    var filteredTopCharts: [TopChartsResults] = []
    var presenter: MainPagePresentationLogic?
    var worker: MainPageWorkingLogic?
    
    
    init(worker: MainPageWorkingLogic) {
        self.worker = worker
    }
    
    func fetchSearch(request: MainPage.FetchMusics.Request) {
        worker?.fetchSearch(request: SearchPurpleAttributes.Request(term: request.searchText ?? ""), completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case let .success(response):
                guard let searchPlaylists = response.results else {return}
                self.searchPlaylists?.append(searchPlaylists)
                self.presenter?.presentPlaylists(response: .init(search: self.searchPlaylists))
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchTopCharts(request: MainPage.FetchMusics.Request) {
        worker?.fetchTopChart(completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case let .success(response):
                guard let topCharts = response.results else {return}
                self.topCharts?.append(topCharts)
                self.presenter?.presentTopCharts(response: .init(topCharts: self.topCharts))
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    func fetchFilterTopCharts(request: MainPage.FetchMusics.Request) {
        if (request.searchText?.count ?? 0) > 2 {
            filteredTopCharts = topCharts?.filter({ (topCharts:TopChartsResults)-> Bool in
                for item in topCharts.songs?.first?.data ?? [] {
                    return item.attributes?.artistName?.contains(request.searchText?.lowercased() ?? "") ?? false
                }
                return true
            }) ?? []
        }else {
            filteredTopCharts = self.topCharts ?? []
        }
        self.presenter?.presentTopCharts(response: .init(topCharts: filteredTopCharts))
    }
    
    func fetchPlaylists(request: MainPage.FetchMusics.Request) {
        worker?.fetchPlaylists(completion: { [weak self] result  in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.fetchCatalogPlaylists(with: response.data ?? [])
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchCatalogPlaylists(with playlists: [Playlists]){
        
        let group = DispatchGroup()
        
        for item in playlists {
            group.enter()
            self.worker?.fetchCatalogPlaylists(id: item.attributes?.playParams?.globalID ?? "") { [weak self] result in
                guard let self = self else {return}
                group.leave() 
                switch result {
                case let .success(response):
                    guard let playlist = response.data?.first else {return }
                    self.catalogPlaylists?.append(playlist)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
        group.notify(queue: .main, execute: {
            //Update Userinterface
            self.presenter?.presentPlaylists(response: .init(catalogPlaylists: self.catalogPlaylists))
            })
        //log mekanizması servis cagrısını aldıktan sonra presenterdan response present etmemiz gerekiyor. DispatchGroup(enter,leave,notify)
        // DispatchGroup: responseları biz presenterdan göndericez fakat hepsinin gelmesini beklememiz gerekiyor bunun için de DispatchGroup kullanıyoruz.
    }
}
