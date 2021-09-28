//
//  PlaylistDetailViewController.swift
//  MusicApp
//
//  Created by mobven semih on 1.09.2021.
//

import UIKit
import AVFoundation
import SDWebImage

protocol PlaylistDetailDisplayLogic: AnyObject {
    func displayFetchPlaylistDetail(viewModel: PlaylistDetail.FetchPlaylistMusic.ViewModel)
    func animateTable()
    func configure()
}

final class PlaylistDetailViewController: UIViewController {
    @IBOutlet weak var playlistDetailTableView: UITableView!
    @IBOutlet weak var playlistImageView: UIImageView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songsCountLabel: UILabel!
    @IBOutlet weak var songsTimeLabel: UILabel!
    @IBOutlet weak var playButtonView: UIView!
    var interactor: PlaylistDetailBusinessLogic?
    var router: (PlaylistDetailRoutingLogic & PlaylistDetailDataPassing)?
    var displayPlaylistDetail: [PlaylistDetail.FetchPlaylistMusic.ViewModel.PlaylistDetailInfo] = []
    var catalogPlaylist: [CatalogPlaylistsInfo] = []
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistDetailTableView.delegate = self
        playlistDetailTableView.dataSource = self
        playlistDetailTableView.register(cellType: PlaylistSongsTableViewCell.self)
        interactor?.fetchPlaylistDetail(request: .init())
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        if player?.rate == 0 {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default, options: [.mixWithOthers])
                try AVAudioSession.sharedInstance().setActive(true)
            }catch {
                print("error")
            }
        
            player?.play()
            self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            self.playButton.tintColor = UIColor(hex: "FFFFFF")
            
        }else {
            self.playButton.setImage(UIImage(systemName: ""), for: .normal)
            self.playButton.tintColor = UIColor(hex: "FFFFFF")
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func configure() {
        playButtonView.layer.masksToBounds = true
        playButtonView.layer.cornerRadius = playButtonView.frame.height / 2
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PlaylistDetailInteractor(worker: PlaylistDetailWorker())
        let presenter = PlaylistDetailPresenter()
        let router = PlaylistDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension PlaylistDetailViewController: PlaylistDetailDisplayLogic {
    func displayFetchPlaylistDetail(viewModel: PlaylistDetail.FetchPlaylistMusic.ViewModel) {
        displayPlaylistDetail = viewModel.playlistDetailInfo
        for item in viewModel.playlistDetailInfo {
            playlistNameLabel.text = item.albumName
        }
        for item in displayPlaylistDetail {
            if item.songImageUrl?.contains("{w}") ?? false && ((item.songImageUrl?.contains("{h}")) != nil) {
                self.playlistImageView.sd_setImage(with: URL(string:item.songImageUrl?.replacingOccurrences(of: "{w}", with: "1080").replacingOccurrences(of: "{h}", with: "1080") ?? ""))
            } else {
                self.playlistImageView.sd_setImage(with: URL(string: item.songImageUrl ?? ""))
            }
        }
        songsCountLabel.text = "\(displayPlaylistDetail.count) songs"
   
        for item in viewModel.playlistDetailInfo {
            var totalTimes = 0
            totalTimes += item.duration ?? 0
            let secondsTimes = totalTimes.msToSeconds
            songsTimeLabel.text = "\(secondsTimes) minutes"
        }
        
        playlistDetailTableView.isHidden = false
        playlistDetailTableView.reloadData()
    }
}

extension PlaylistDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayPlaylistDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistDetailTableView.dequeCell(cellType: PlaylistSongsTableViewCell.self, indexPath: indexPath)
        cell.configureCell(model: displayPlaylistDetail[indexPath.row])
        let myView = UIView()
        myView.backgroundColor = UIColor(hex: "220D3C")
        UITableViewCell.appearance().selectedBackgroundView = myView
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToMusicPlayer(index: indexPath.row)
    }
    
    func animateTable() {
        playlistDetailTableView.reloadData()
        let cells = playlistDetailTableView.visibleCells
        
        let tableViewHeight = playlistDetailTableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut,animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
}
