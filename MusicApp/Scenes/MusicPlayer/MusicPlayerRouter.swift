//
//  MusicPlayerRouter.swift
//  MusicApp
//
//  Created by mobven semih on 4.09.2021.
//

import UIKit

protocol MusicPlayerRoutingLogic: AnyObject {
}

protocol MusicPlayerDataPassing: AnyObject {
    var dataStore: MusicPlayerDataStore? { get }
}

final class MusicPlayerRouter: MusicPlayerRoutingLogic, MusicPlayerDataPassing {
    
    weak var viewController: MusicPlayerViewController?
    var dataStore: MusicPlayerDataStore?
}
