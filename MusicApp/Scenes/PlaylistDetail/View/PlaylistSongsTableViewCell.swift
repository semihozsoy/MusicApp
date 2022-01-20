//
//  PlaylistSongsTableViewCell.swift
//  MusicApp
//
//  Created by mobven semih on 5.09.2021.
//

import UIKit

class PlaylistSongsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var musicImageContainer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: PlaylistDetail.FetchPlaylistMusic.ViewModel.PlaylistDetailInfo) {
        songNameLabel.text = model.songName
        songNameLabel.textColor = UIColor(hex: "E5DAEE")
        playlistNameLabel.text = model.albumName
        musicImageContainer.layer.masksToBounds = true
        musicImageContainer.layer.cornerRadius = musicImageContainer.frame.height / 2
    }
    

    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if likeButton.tag == 0 {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tag = 1
        }else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tag = 0
            likeButton.imageView?.tintColor = UIColor(hex: "E125B0")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
