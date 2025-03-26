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
    var pokemonService = PokemonAPI()
    private var offset: Int { return pokemons.count }
    private var limit: Int = 24
    private var isFetching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        fetchPokemons()
    }
    
    //Bütün Pokemonları almak için kullandığımız fonksiyon
    func fetchPokemons() {
        Task {
            do {
                try await pokemonService.fetchPokemons(offset: 0, limit: limit)
                self.pokemons = pokemonService.pokemons
                for pokemon in self.pokemons {
                    let detail = try await pokemonService.fetchPokemonDetails(url: pokemon.url)
                    self.pokemonDetailDict[pokemon.name] = detail
                }
                DispatchQueue.main.async {
                    self.pokemonTableView.reloadData()
                }
            } catch {
                print("Error fetching Pokémon:", error)
            }
        }
    }
    
    //Pagination sağlayan fonksiyon.
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
    
    // Table view kaç satır olacak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    //Cell'lerde ne olacak. PokemonTableViewCell'den configure fonksiyonunu çağırıyoruz
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
    
    //Cell seçildi
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seçilen Pokémon:", pokemons[indexPath.row].name) // Test için ekle
        let detailScreen = self.storyboard?.instantiateViewController(withIdentifier: "detailScreen") as! DetailScreenViewController
            detailScreen.pokemon = pokemons[indexPath.row]
            detailScreen.pokemonDetail = pokemonDetailDict[pokemons[indexPath.row].name]
        detailScreen.title = pokemons[indexPath.row].name.capitalized
        self.navigationController?.pushViewController(detailScreen, animated: true)
        //performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    //Pagination için triggerIndex oluşturduk ve bu değere göre loadMorePokemon() çalışıyor.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let triggerIndex = pokemons.count - 5
        if indexPath.row >= triggerIndex {
            loadMorePokemon()
        }
    }
}

/*Detail ekranına verileri yollama
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "detailSegue",
       let destinationVC = segue.destination as? DetailScreenViewController,
       let indexPath = sender as? IndexPath {
           destinationVC.pokemon = pokemons[indexPath.row]
        if let details = pokemonDetailDict[pokemons[indexPath.row].name] {
            destinationVC.pokemonDetail = details
            destinationVC.modalPresentationStyle = .fullScreen
        }
    }
}*/


