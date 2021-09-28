//
//  UITableViewCell+Extension.swift
//  MusicApp
//
//  Created by mobven semih on 3.09.2021.
//

import UIKit


extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
