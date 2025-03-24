//
//  DetailTableViewCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 24.03.2025.
//

import Foundation
import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    func configureImage(url: String) {
        self.pokemonImage.kf.setImage(with: URL(string: url))
    }

}
