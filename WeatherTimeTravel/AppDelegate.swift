//
//  AppDelegate.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 01.11.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        Router.shared.navigateTo(screen: .placeSelector)
        return true
    }

}

