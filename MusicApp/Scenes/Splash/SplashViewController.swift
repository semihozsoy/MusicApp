//
//  SplashViewController.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import UIKit
import StoreKit
class SplashViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizationMediaLibrary()
    }
    
    func requestAccess(){
        SKCloudServiceController.requestAuthorization { status in}
    }
    func authorizationMediaLibrary() {
        switch SKCloudServiceController.authorizationStatus() {
        case .notDetermined:
            self.requestAccess()
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        case .authorized:
            MusicUserToken().generateMusicToken { token in
                UserDefaults.standard.setValue(token, forKey: "MusicUserToken")
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    let storyBoard = UIStoryboard(name: "MainPage", bundle: nil)
                    let destVC = storyBoard.instantiateViewController(withIdentifier: "mainPageVC")
                    destVC.modalPresentationStyle = .overFullScreen
                    self.present(destVC, animated: false, completion: nil)
                }
            }
            
        @unknown default:
            fatalError()
        }
    }
}
