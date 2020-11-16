//
//  LocationCell.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 16.11.2020.
//

import UIKit

class LocationCell: UITableViewCell {
    
    let mainLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(mainLabel)
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            mainLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 16.0),
            mainLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16.0),
        ])
        mainLabel.text = "Test"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public static func reuseIdentifier() -> String {
        NSStringFromClass(self)
    }

}
