//
//  MainPageViewController.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import UIKit

protocol MainPageDisplayLogic: AnyObject {
    func displayFetchedPlaylists(viewModel:MainPage.FetchMusics.ViewModel)
}

final class MainPageViewController: UIViewController {
    let networkManager = NetworkManager<MusicEndpointItem>()
    var interactor: MainPageBusinessLogic?
    var router: (MainPageRoutingLogic & MainPageDataPassing)?
    var displayPlaylists: MainPage.FetchMusics.ViewModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        let request = MainPage.FetchMusics.Request()
        interactor?.fetchPlaylists(request: request)
        interactor?.fetchCatalogPlaylists(request: request)
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = MainPageInteractor(worker: MainPageWorker())
        let presenter = MainPagePresenter()
        let router = MainPageRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension MainPageViewController: MainPageDisplayLogic {
    func displayFetchedPlaylists(viewModel: MainPage.FetchMusics.ViewModel) {
        displayPlaylists = viewModel
    }
    
    
}
