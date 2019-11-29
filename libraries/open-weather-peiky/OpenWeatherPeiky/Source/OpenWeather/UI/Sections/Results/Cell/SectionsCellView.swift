//
//  SectionsCellView.swift
//  OpenWeatherPeiky
//
//  Created by Ibrahimme Morelo on 11/28/19.
//

import UIKit
import Nuke

final class SectionsCellView: UICollectionViewCell {
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    func setup(_ openWeatherDetail: OpenWeatherDetail) {
        let data = openWeatherDetail.weather[0]
        descriptionLabel.text = data.description
        if let url = URL(string: ServiceDefinitions.iconImage(name: data.icon)) {
            Nuke.loadImage(with: url, into: iconImageView)
        }
    }
}
