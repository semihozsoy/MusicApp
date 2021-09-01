//
//  MainPageRouter.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation

protocol MainPageRoutingLogic: AnyObject {
}

protocol MainPageDataPassing: AnyObject {
    var dataStore: MainPageDataStore? { get }
}

final class MainPageRouter: MainPageRoutingLogic, MainPageDataPassing {
    weak var viewController: MainPageViewController?
    var dataStore: MainPageDataStore?
}
