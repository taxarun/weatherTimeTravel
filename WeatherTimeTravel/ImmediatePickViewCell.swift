//
//  ImmediatePickViewCell.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 01.11.2020.
//

import UIKit

class ImmediatePickViewCell: UITableViewCell {

    var mainLabel : UILabel?
    
    public func configureWithTitle(title : String) {
        if mainLabel == nil {
            mainLabel = UILabel()
            mainLabel!.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(mainLabel!)
            NSLayoutConstraint.activate([
                mainLabel!.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                mainLabel!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                mainLabel!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 16.0),
                mainLabel!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16.0),
            ])
        }
        
        mainLabel?.text = title
    }
    
    public static func reuseIdentifier() -> String {
        NSStringFromClass(self)
    }

}
