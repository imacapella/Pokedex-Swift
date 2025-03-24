//
//  ViewController.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 20.03.2025.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pokemonTableView: UITableView!
    
    // Pokemon ve detay dizileri
    private var pokemons: [Pokemon] = []
    private var pokemonDetailDict: [String: PokemonDetail] = [:]
    var pokemonService = PokeAPIManager()
    private var offset: Int { return pokemons.count }
    private var limit: Int = 24
    private var isFetching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        fetchPokemons()
        
    }
    
    func loadMorePokemon() {
        guard !isFetching else { return }
        isFetching = true
        
        Task {
            do {
                let newOffset = self.pokemons.count
                
                try await pokemonService.fetchPokemons(offset: newOffset, limit: limit)
                
                let newPokemons = pokemonService.pokemons
                self.pokemons += newPokemons
                
                for pokemon in newPokemons {
                    let detail = try await pokemonService.fetchPokemonDetails(url: pokemon.url)
                    self.pokemonDetailDict[pokemon.name] = detail
                }
                
                DispatchQueue.main.async {
                    self.pokemonTableView.reloadData()
                    self.isFetching = false
                }
            } catch {
                isFetching = false
                print("Error:", error)
            }
        }
    }
    
    func fetchPokemons() {
        Task {
            do {
                try await pokemonService.fetchPokemons(offset: 0, limit: limit)
                self.pokemons = pokemonService.pokemons
                DispatchQueue.main.async {
                    self.pokemonTableView.reloadData()
                }
                
                for pokemon in self.pokemons {
                    let detail = try await pokemonService.fetchPokemonDetails(url: pokemon.url)
                    DispatchQueue.main.async {
                        self.pokemonDetailDict[pokemon.name] = detail
                        self.pokemonTableView.reloadData()
                    }
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
        cell.configureLabel(pokemon: pokemon)
        if let detail = pokemonDetailDict[pokemon.name] {
            cell.configureImage(detail: detail)
        } else {
            cell.img.image = UIImage(named: "placeholder")
        }
        return cell
    }
    
    //Pokemon seçildi
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seçilen Pokémon:", pokemons[indexPath.row].name) // Test için ekle
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    //Detail ekranına verileri yollama
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue",
           let destinationVC = segue.destination as? DetailScreenViewController,
           let indexPath = sender as? IndexPath {
            destinationVC.pokemon = pokemons[indexPath.row]
            if let details = pokemonDetailDict[pokemons[indexPath.row].name] {
                destinationVC.pokemonDetail = details
            }
            print("Gönderilen Pokémon:", destinationVC.pokemon?.name ?? "Boş")
            print("Gönderilen Detay:", destinationVC.pokemonDetail ?? "Boş")
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let triggerIndex = pokemons.count - 5
        if indexPath.row >= triggerIndex {
            loadMorePokemon()
        }
    }
}




