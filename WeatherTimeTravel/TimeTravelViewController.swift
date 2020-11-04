//
//  TimeTravelViewController.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 01.11.2020.
//

import UIKit

class TimeTravelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = ImmediatePickView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25),
            picker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            picker.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            picker.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
        
        let elementsCount : UInt = 23
        
        picker.refresh(elementsNum: elementsCount) { (row) -> String in
            "Test"
        }
        
        _ = picker.currentElement.subscribe(onNext: { [weak self] (index) in
            UIView.animate(withDuration: 0.2) {
                self?.view.backgroundColor = UIColor(white: CGFloat(index) / CGFloat(elementsCount), alpha: 1.0)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}

