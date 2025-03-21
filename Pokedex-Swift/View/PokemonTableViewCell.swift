//
//  PokemonTableViewCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 21.03.2025.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(pokemon: Pokemon) {
        label.text = pokemon.name
    }
    
    
}
