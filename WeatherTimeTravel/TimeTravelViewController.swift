//
//  TimeTravelViewController.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 01.11.2020.
//

import UIKit
import SpriteKit

class TimeTravelViewController: UIViewController {

    let scene = SKScene()
    let effectsView = SKView()
    let emitterNode = SKEmitterNode(fileNamed: "Rain.sks")!
    
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
        
        effectsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(effectsView)
        NSLayoutConstraint.activate([
            effectsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            effectsView.bottomAnchor.constraint(equalTo: picker.topAnchor),
            effectsView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            effectsView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
        effectsView.backgroundColor = .clear
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        effectsView.presentScene(scene)
        effectsView.isUserInteractionEnabled = false
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(emitterNode)
    }
    
    override func viewDidLayoutSubviews() {
        scene.size = effectsView.frame.size
        emitterNode.position.y = scene.frame.maxY
        emitterNode.particlePositionRange.dx = scene.frame.width
    }
}

