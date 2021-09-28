//
//  MainPageViewController.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import UIKit
import SDWebImage
import AVFoundation

protocol MainPageDisplayLogic: AnyObject {
    func displayFetchedPlaylists(viewModel: MainPage.FetchMusics.ViewModel)
    func displayTopCharts(viewModel: MainPage.FetchMusics.ViewModel)
}

final class MainPageViewController: UIViewController {
    var interactor: MainPageBusinessLogic?
    var router: (MainPageRoutingLogic & MainPageDataPassing)?
    
    @IBOutlet weak var musicPlayerPauseButton: UIButton!
    @IBOutlet weak var musicPlayerSongNameLabel: UILabel!
    @IBOutlet weak var musicPlayerView: UIView!
    @IBOutlet weak var musicPlayerSongImage: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    var displayCatalog: [MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo] = []
    var displayTopCharts: [MainPage.FetchMusics.ViewModel.TopChartsInfo] = []
    var displaySearchs: [MainPage.FetchMusics.ViewModel.SearchInfo] = []
    var player: AVPlayer?
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
    
    override func viewDidLoad() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(cellType: TopChartTableViewCell.self)
        mainTableView.register(cellType: SearchTableViewCell.self)
        mainTableView.register(cellType: CollectionTableViewCell.self)
        interactor?.fetchTopCharts(request: .init())
        interactor?.fetchPlaylists(request: .init())
        interactor?.fetchSearch(request: .init())
        configureMusicPlayer()
        hideKeyBoardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        musicPlayerSongNameLabel.text = UserDefaults.standard.value(forKey: "songNameLabel") as? String
        let playingSongImage = UserDefaults.standard.value(forKey: "songImageUrl") ?? ""
           let correctImage = (playingSongImage as AnyObject).replacingOccurrences(of: "{w}x{h}bb.jpeg", with: "/3000x3000bb.webp")
           musicPlayerSongImage.sd_setImage(with: URL(string: correctImage ))
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        
        var savedMusicPlayer = UserDefaults.standard.object(forKey: "musicPlayer") as? AVPlayer
        savedMusicPlayer = player
        
        if savedMusicPlayer?.rate == 0 {
            savedMusicPlayer?.play()
            self.musicPlayerPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            self.musicPlayerPauseButton.tintColor = UIColor(hex: "FFFFFF")
            
        }else {
            self.musicPlayerPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            self.musicPlayerPauseButton.tintColor = UIColor(hex: "FFFFFF")
            savedMusicPlayer?.pause()
        }
    }

    func configureMusicPlayer() {
        musicPlayerPauseButton.layer.cornerRadius = musicPlayerPauseButton.frame.size.width / 2
        musicPlayerPauseButton.clipsToBounds = true
        
        musicPlayerView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner,.layerMinXMinYCorner]
        musicPlayerView.layer.cornerRadius = 20
        musicPlayerView.layer.masksToBounds = false
        musicPlayerView.clipsToBounds = true
        musicPlayerSongImage.layer.cornerRadius = musicPlayerSongImage.frame.size.width / 2
        musicPlayerSongImage.layer.masksToBounds = false
        musicPlayerSongImage.clipsToBounds = true
    }

}

extension MainPageViewController: MainPageDisplayLogic {
    func displayFetchedPlaylists(viewModel: MainPage.FetchMusics.ViewModel) {
        displayCatalog = viewModel.catalogPlaylistInfo!
        displaySearchs = viewModel.searchInfo!
        mainTableView.isHidden = false
        view.backgroundColor = UIColor(hex: "220D3C")
        mainTableView.reloadData()
    }
    
    func displayTopCharts(viewModel: MainPage.FetchMusics.ViewModel) {
        displayTopCharts = viewModel.topChartsInfo!
        mainTableView.reloadData()
    }
}

extension MainPageViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch MainPage.Sections(rawValue: section) {
        case .search, .playlists:
            return 1
        case .topChart:
            return displayTopCharts.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch MainPage.Sections(rawValue: indexPath.section) {
        case .search:
            let cell = mainTableView.dequeCell(cellType: SearchTableViewCell.self, indexPath: indexPath)
            cell.configureSearchCell()
            cell.delegate = self
            return cell
        case .playlists:
            let cell = mainTableView.dequeCell(cellType: CollectionTableViewCell.self, indexPath: indexPath)
            cell.configure(model: displayCatalog)
            cell.delegate = self
            return cell
        case .topChart:
            let cell = mainTableView.dequeCell(cellType: TopChartTableViewCell.self, indexPath: indexPath)
            cell.configureFavoriteCell(model: displayTopCharts[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        switch MainPage.Sections(rawValue: section) {
        case .search:
            return tableView.createHeader(labelText: "Library", labelTextColor: UIColor(hex: "FFFFFF"),labelFont: .systemFont(ofSize:32,weight:.bold),headerBackgroundColor: UIColor(hex: "220D3C"))
        case .playlists:
            return tableView.createHeader(labelText: "Playlists", labelTextColor: UIColor(hex: "FFFFFF"),labelFont: .systemFont(ofSize:22,weight:.semibold),headerBackgroundColor: UIColor(hex: "220D3C"))
        case .topChart:
            return tableView.createHeader(labelText: "Top Chart", labelTextColor: UIColor(hex: "FFFFFF"),labelFont: .systemFont(ofSize:22,weight:.bold),headerBackgroundColor: UIColor(hex: "220D3C"))
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension MainPageViewController: CollectionTableViewCellDelegate {
    func collectionTableViewCell(_ cell: UITableViewCell, didTappedItemAt index: Int) {
        router?.routeToPlaylistDetail(index: index)
    }
}

extension MainPageViewController: SearchTableViewCellDelegate {
    func searchTableViewCell(_ searchText: String) {
        interactor?.fetchFilterTopCharts(request: .init(searchText: searchText))
        
//        if textField.text?.count != 0 {
//            for searchItems in displaySearchs {
//                if let searchToMusic = textField.text {
//                    let artistNameRange = searchItems.artistName?.lowercased().range(of: searchToMusic ,options: .caseInsensitive,range: nil, locale:nil)
//                    let nameRange = searchItems.name?.lowercased().range(of: searchToMusic, options: .caseInsensitive , range: nil, locale: nil)
//                    if (artistNameRange != nil) && nameRange != nil {
//                        self.displaySearchs.append(searchItems)
//                    }
//                }
//            }
//        }
    }
    

}

extension MainPageViewController {
    func hideKeyBoardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
