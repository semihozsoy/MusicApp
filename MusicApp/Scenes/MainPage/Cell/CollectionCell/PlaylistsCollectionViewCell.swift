//
//  PlaylistsCollectionViewCell.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import UIKit
import SDWebImage

class PlaylistsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playlistImage: UIImageView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var playlistsView: UIView!
    @IBOutlet weak var songCountLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configureCellMain(model: MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo) {
        self.playlistNameLabel.text = model.albumName
        if model.imageUrl?.contains("{w}") ?? false && ((model.imageUrl?.contains("{h}")) != nil) {
            self.playlistImage.sd_setImage(with: URL(string:model.imageUrl?.replacingOccurrences(of: "{w}", with: "1080").replacingOccurrences(of: "{h}", with: "1080") ?? ""))
        } else {
            self.playlistImage.sd_setImage(with: URL(string: model.imageUrl ?? ""))
        }
        songCountLabel.text = "\(model.songCount ?? 0) songs"
    }
}

