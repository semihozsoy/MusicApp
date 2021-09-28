//
//  CollectionTableViewCell.swift
//  MusicApp
//
//  Created by mobven semih on 2.09.2021.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCell(_ cell: UITableViewCell, didTappedItemAt index: Int)
}

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var catalogPlaylist: [MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo] = []
    weak var delegate: CollectionTableViewCellDelegate?
    
    func configure(model: [MainPage.FetchMusics.ViewModel.CatalogPlaylistsInfo]){
        self.catalogPlaylist = model
        collectionView.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(cellType: PlaylistsCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self 
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = UIColor(hex: "220D3C")
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogPlaylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: PlaylistsCollectionViewCell.self, indexPath: indexPath)
        cell.configureCellMain(model: catalogPlaylist[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 321, height: 310)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.collectionTableViewCell(self, didTappedItemAt: indexPath.item)
    }
}
