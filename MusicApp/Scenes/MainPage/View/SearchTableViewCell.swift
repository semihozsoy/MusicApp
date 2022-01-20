//
//  SearchTableViewCell.swift
//  MusicApp
//
//  Created by mobven semih on 2.09.2021.
//

import UIKit

protocol SearchTableViewCellDelegate: AnyObject {
    func searchTableViewCell(_ searchText: String)
}

class SearchTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    weak var delegate: SearchTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.delegate = self
        
        searchTextField.addTarget(self, action: #selector(searchMusics), for: .editingChanged)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = UIColor(hex: "220D3C")
    }
    func configureSearchCell() {
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Song or artist...",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "A989C5")])
       
        searchImage.tintColor = UIColor(hex: "A989C5")
        searchView.layer.cornerRadius = 14
        searchView.layer.masksToBounds = true
        searchView.backgroundColor = UIColor(hex: "3F225D")
        searchView.frame.size = CGSize(width: 150, height: 67)
    }
    
}

extension SearchTableViewCell {
    @objc func searchMusics(){
        self.delegate?.searchTableViewCell(searchTextField.text ?? "")
    }
}
