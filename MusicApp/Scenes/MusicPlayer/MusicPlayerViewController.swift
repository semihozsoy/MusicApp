//
//  MusicPlayerViewController.swift
//  MusicApp
//
//  Created by mobven semih on 4.09.2021.
//

import UIKit
import SDWebImage
import AVFoundation
import AVKit

protocol MusicPlayerDisplayLogic: AnyObject {
    func displayFetchMusicPlayer(viewModel: MusicPlayer.FetchMusic.ViewModel)
    func configureUI()
}

final class MusicPlayerViewController: UIViewController {
    
    var interactor: MusicPlayerBusinessLogic?
    var router: (MusicPlayerRoutingLogic & MusicPlayerDataPassing)?
    var fetchMusicUrl: [MusicPlayer.FetchMusic.ViewModel.MusicPlayerInfo] = []
    var playerItems: [AVPlayerItem] = []
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    static let sharedInstance = MusicPlayerViewController()
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var sliderMusicTime: UISlider!
    @IBOutlet weak var musicButtonsView: UIView!
    @IBOutlet weak var soundOnOffButton: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var finishTimeLabel: UILabel!
  
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
        let interactor = MusicPlayerInteractor(worker: MusicPlayerWorker())
        let presenter = MusicPlayerPresenter()
        let router = MusicPlayerRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchMusic(request: .init(index: nil))
        configureUI()
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureUI() {
        
        for state: UIControl.State in [.normal, .selected, .application, .reserved] {
            sliderMusicTime.setThumbImage(UIImage.init(), for: state)
        }
        musicButtonsView.layer.cornerRadius = 15
        musicButtonsView.layer.masksToBounds = false
        musicButtonsView.clipsToBounds = true
        
        albumImageView.layer.masksToBounds = true
        albumImageView.layer.cornerRadius = albumImageView.frame.height / 2
        
        pauseButton.layer.masksToBounds = true
        pauseButton.layer.cornerRadius = pauseButton.frame.height / 2
    }
    
    deinit {
        // The reason why we are doing is; you're going to have all these observers listening for notifications and it could cause confusion.
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
    }
    
    @IBAction func backwardButtonTapped(_ sender: Any) {
        interactor?.changeMusic(index: -1)
        self.player?.play()
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        
        if player?.rate == 0 {
            player?.play()
            self.pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            self.pauseButton.tintColor = UIColor(hex: "FFFFFF")
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
                    self?.player?.seek(to: CMTime.zero)
                    self!.forwardButtonTapped((Any).self)
                    self?.player?.play()
                  }
            
        }else {
            self.pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            self.pauseButton.tintColor = UIColor(hex: "FFFFFF")
            player?.pause()
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        interactor?.changeMusic(index: +1)
        self.player?.play()
    }
        
    @IBAction func soundOnOffButtonTapped(_ sender: Any) {
        if player?.isMuted == false {
            player?.isMuted = true
            soundOnOffButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }else {
            player?.isMuted = false
            soundOnOffButton.setImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
        }
    }
    
    @IBAction func likeSongButtonTapped(_ sender: Any) {
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(systemName: "heart.fill"),  for: .normal)
            likeButton.tag = 1
        }else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tag = 0
        }
    }
    
    @IBAction func sliderMusicTime(_ sender: Any) {
        sliderMusicTime.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        self.player?.play()
    }
    
    @objc func handleSliderChange() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(sliderMusicTime.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in

            })
        }
    }
}

extension MusicPlayerViewController: MusicPlayerDisplayLogic {
    func displayFetchMusicPlayer(viewModel: MusicPlayer.FetchMusic.ViewModel) {
    
        guard let url = URL(string: viewModel.musicPlayerInfo.songUrl ?? "") else { return }
            let playerItem: AVPlayerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
        pauseButton.addTarget(self, action: #selector(self.pauseButtonTapped(_:)), for: .touchUpInside)
        

        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            let seconds = CMTimeGetSeconds(progressTime)
            let secondString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            self.startTimeLabel.text = "0:\(secondString)"
            if let duration = self.player?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                self.sliderMusicTime.value = Float(seconds / durationSeconds)
            }
        })
 
        songNameLabel.text = viewModel.musicPlayerInfo.songName
        UserDefaults.standard.set(viewModel.musicPlayerInfo.songName, forKey: "songNameLabel")
        playlistNameLabel.text = viewModel.musicPlayerInfo.playlistName
            if viewModel.musicPlayerInfo.songImageUrl?.contains("{w}") ?? false && ((viewModel.musicPlayerInfo.songImageUrl?.contains("{h}")) != nil) {
                albumImageView.sd_setImage(with: URL(string:viewModel.musicPlayerInfo.songImageUrl?.replacingOccurrences(of: "{w}", with: "1080").replacingOccurrences(of: "{h}", with: "1080") ?? ""))
                UserDefaults.standard.set(viewModel.musicPlayerInfo.songImageUrl,forKey: "songImageUrl")
            } else {
                self.albumImageView.sd_setImage(with: URL(string: viewModel.musicPlayerInfo.songImageUrl ?? "" ))
                UserDefaults.standard.set(viewModel.musicPlayerInfo.songImageUrl,forKey: "songImageUrl")
            }
    }
}

extension MusicPlayerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
            navigationController?.popViewController(animated: true)
            self.player?.pause()
        }
        return false
    }
}
