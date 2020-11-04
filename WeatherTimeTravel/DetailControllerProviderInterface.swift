//
//  DetailControllerProviderInterface.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 04.11.2020.
//

import UIKit
import RxSwift

protocol DetailControllerProviderInterface {
    
    func getDetailNavigationObservable() -> BehaviorSubject<NavigationDestination>
    
}
