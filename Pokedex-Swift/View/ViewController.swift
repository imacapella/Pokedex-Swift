//
//  ViewController.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 20.03.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    // Pokemon ve detay dizileri
    var pokemons: [Pokemon] = []
    var pokemonDetail: [PokemonDetail] = []
    var pokemonService = PokeAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        Task {
            do {
                // Pokemonları çekiyoruz
                try await pokemonService.fetchPokemons()
                // Pokemonları alıyoruz ve UI'yi güncelliyoruz
                self.pokemons = pokemonService.pokemons
                DispatchQueue.main.async {
                    self.pokemonTableView.reloadData()
                }
                
                // Pokemon detaylarını çekiyoruz
                for pokemon in self.pokemons {
                    let detail = try await pokemonService.fetchPokemonDetails(url: pokemon.url)
                    self.pokemonDetail.append(detail)
                    print(pokemonDetail)
                }
                print(pokemonDetail)
                
                DispatchQueue.main.async {
                    self.pokemonTableView.reloadData()
                }
                
            } catch {
                print("Error fetching Pokémon:", error)
            }
        }
    }
    
    // Table view satırları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = pokemons[indexPath.row]
        
        let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "poke", for: indexPath) as! PokemonTableViewCell
        cell.configure(pokemon: pokemon)
        
        return cell
    }
}




    
    


