//
//  DetailScreenViewController.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 24.03.2025.
//

import Foundation
import UIKit
import Kingfisher

class DetailScreenViewController: UIViewController {
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var pokemon: Pokemon?
    var pokemonDetail: PokemonDetail?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        activityIndicator.stopAnimating()
        if let pokemon = pokemon, let detail = pokemonDetail {
            pokemonName.text = pokemon.name
            if let imageUrl = URL(string: detail.sprites.frontDefault) {
                self.pokemonImage.kf.setImage(with: imageUrl)
            }
            pokemonName.isHidden = false
            pokemonImage.isHidden = false
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let pokemon = pokemon, let detail = pokemonDetail {
            pokemonName.isHidden = false
            pokemonImage.isHidden = false
            print("Detay Sayfasına Gelen Pokémon:", pokemon.name)
            
        } else {
            print("DetailScreenViewController içinde veri boş")
            viewWillAppear(true)
        }
    }
    
    func updateUI() {
        pokemonName.isHidden = false
        pokemonImage.isHidden = false
        activityIndicator.stopAnimating()
    }
}

