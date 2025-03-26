//
//  PokemonTableViewCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 21.03.2025.
//

import UIKit
import Kingfisher

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    func configureLabel(pokemon: Pokemon) {
        label.text = pokemon.name.capitalized
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
  
    func configureImage(detail: PokemonDetail) {
        self.img.kf.setImage(with: URL(string: detail.sprites.frontDefault)!)
    }
}
