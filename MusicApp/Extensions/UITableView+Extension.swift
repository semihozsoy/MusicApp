//
//  UITableView+Extension.swift
//  MusicApp
//
//  Created by mobven semih on 3.09.2021.
//

import UIKit

extension UITableView {
    func register(cellType: UITableViewCell.Type){
        register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    func dequeCell<T:UITableViewCell>(cellType:T.Type,indexPath:IndexPath)->T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else{
            fatalError()
        }
        return cell
    }
    
    func createHeader(labelText: String, labelTextColor: UIColor, labelFont: UIFont, headerBackgroundColor: UIColor ) -> UIView{
        let header = UIView()
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: 300, height: 35))
        label.text = labelText
        label.textColor = labelTextColor
        label.font = labelFont
        header.backgroundColor = headerBackgroundColor
        header.addSubview(label)
        return header
    }
}
