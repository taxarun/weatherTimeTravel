//
//  Router.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 04.11.2020.
//

import UIKit

enum NavigationDestination {
    case placeSelector
    case weatherTimeTravel
    case blank
}

class Router {
    static let shared = Router()
    private init() {}
    
    public func navigateTo(screen: NavigationDestination) {
        
        var controllerToPresent = self.p_getControllerForNavigation(screen: screen)
        
        if UIDevice.current.userInterfaceIdiom == .pad, let detailProvider = controllerToPresent as? DetailControllerProviderInterface {
            
            let detailScreenProvider = detailProvider.getDetailNavigationObservable()
            var detailScreen = try? detailScreenProvider.value()
            if detailScreen != nil {
                let detailController = self.p_getControllerForNavigation(screen: detailScreen!)
                let splitController = UISplitViewController()
                splitController.viewControllers = [controllerToPresent, detailController]
                controllerToPresent = splitController
                _ = detailScreenProvider.subscribe(onNext: { (newDestination) in
                    if detailScreen != newDestination {
                        detailScreen = newDestination
                        let newDetailController = self.p_getControllerForNavigation(screen: detailScreen!)
                        splitController.viewControllers[1] = newDetailController
                    }
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            }
            
        }
        
        let window : UIWindow? = UIApplication.shared.delegate?.window!
        if window != nil {
            let currentRoot = window!.rootViewController
            if currentRoot == nil {
                window!.rootViewController = controllerToPresent
            } else {
                var topController = currentRoot!
                while topController.presentedViewController != nil {
                    topController = topController.presentedViewController!
                }
                if let split = topController as? UISplitViewController {
                    if split.viewControllers.count > 1 {
                        topController = split.viewControllers[1]
                    }
                }
                topController.present(controllerToPresent, animated: true, completion: nil)
            }
        }
    }
    
    private func p_getControllerForNavigation(screen: NavigationDestination) -> UIViewController {
        switch screen {
        case .placeSelector:
            return LocationSelectionViewController()
        case .weatherTimeTravel:
            return TimeTravelViewController()
        case .blank:
            let controller = UIViewController()
            controller.view.backgroundColor = UIColor.red
            return controller
        }
    }
}
