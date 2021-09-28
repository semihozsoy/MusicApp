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
            //MusicUserToken().generateMusicToken { token in
            let token = "Av1AZspRz82yPJ+CVQTmxVs5Gnpkx3ltNtaPq4udTHm/nR25z+TVslYxBwKZ2hDWxhiji7F+8xrilDkRdKu7u3l0b5Xpeg5jzL7qLNjywtO5QiyXlKri9hPxGVq2aJdyYtYRNR1JuBizBa1tCBSYTVSRw1lDz10RTzSFnKE4qU6b/10Br2OnKE4gwsNyAwGWquiOJG1UBkOay0urYwlJiJvkq7TyzMArbBBRTc7HTPA5H+bdpg=="
                UserDefaults.standard.setValue(token, forKey: "MusicUserToken")
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    let storyBoard = UIStoryboard(name: "MainPage", bundle: nil)
                    let destVC = storyBoard.instantiateViewController(withIdentifier: "mainPageVC")
                    let navigationVC = UINavigationController(rootViewController: destVC)
                    navigationVC.modalPresentationStyle = .overFullScreen
                    self.present(navigationVC, animated: false, completion: nil)
                }
           //}
            
        @unknown default:
            fatalError()
        }
    }
}
