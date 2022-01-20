//
//  FavoriteTableViewCell.swift
//  MusicApp
//
//  Created by mobven semih on 2.09.2021.
//

import UIKit
import SDWebImage

class TopChartTableViewCell: UITableViewCell {
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playlistNameLabel: UILabel!
    @IBOutlet weak var topChartView: UIView!
    @IBOutlet weak var musicNoteImageView: UIImageView!
    @IBOutlet weak var musicNoteView: UIView!
    
    var catalogPlaylist: [MainPage.FetchMusics.ViewModel.TopChartsInfo] = []
    
    func configureFavoriteCell(model: MainPage.FetchMusics.ViewModel.TopChartsInfo){
        playlistNameLabel.text = model.playlistName
        songNameLabel.text = model.name
        let correctImageFormat = model.image?.replacingOccurrences(of: "{w}x{h}bb.jpeg", with: "/3000x3000bb.webp") ?? ""
        musicNoteImageView.sd_setImage(with: URL(string: correctImageFormat))
        musicNoteView.layer.cornerRadius = musicNoteImageView.frame.size.width / 2
        musicNoteView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = UIColor(hex: "220D3C")
    }
    
}
