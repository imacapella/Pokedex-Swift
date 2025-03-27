//  ViewController.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 20.03.2025

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var pokemonTableView: UITableView!
  private var isFetching: Bool = false
  var pokemonService = PokemonAPI()                                   // PokemonAPI Object
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pokemonTableView.delegate = self
    pokemonTableView.dataSource = self
    if DataManager.shared.pokemons.isEmpty {
      fetchPokemons()
    }
  }
  
  //Bütün Pokemonları almak için kullandığımız fonksiyon
  func fetchPokemons() {
    Task {
      do {
        let fetchedPokemons = try await pokemonService.fetchPokemons(offset: 0, limit: 21)
        DataManager.shared.pokemons = fetchedPokemons
        for pokemon in fetchedPokemons {
          let detail = try await pokemonService.fetchPokemonDetails(url: pokemon.url)
          DataManager.shared.pokemonDetails[pokemon.name] = detail
        }
        DispatchQueue.main.async {                                    // Reload Table View
          self.pokemonTableView.reloadData()                          // Reload Table View
        }                                                             // Reload Table View
      } catch {                                                       // Reload Table View
        print("Error fetching Pokémon:", error)                       // Reload Table View
      }
    }
  }
  
  func loadMorePokemon() {
    guard !isFetching else { return }
    isFetching = true
    
    Task {
      do {
        let newPokemons = try await pokemonService.loadMorePokemon()
        DataManager.shared.pokemons += newPokemons
        
        for pokemon in newPokemons {                                                    // Get New Details
          let detail = try await pokemonService.fetchPokemonDetails(url: pokemon.url)   // Get New Details
          DataManager.shared.pokemonDetails[pokemon.name] = detail                      // Get New Details
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
  
  // How many cell in the TableView
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataManager.shared.pokemons.count
  }
  
  //Cell'lerde ne olacak. PokemonTableViewCell'den configure fonksiyonunu çağırıyoruz
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let pokemon = DataManager.shared.pokemons[indexPath.row]
    let cell = pokemonTableView.dequeueReusableCell(withIdentifier: "poke", for: indexPath) as! PokemonTableViewCell
    cell.configureLabel(pokemon: pokemon)
    if let detail = DataManager.shared.pokemonDetails[pokemon.name] {
      cell.configureImage(detail: detail)
    } else {
      cell.img.image = UIImage(named: "placeholder")
    }
    return cell
  }
  
  //Cell selected.
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Seçilen Pokémon:", DataManager.shared.pokemons[indexPath.row].name) // Test için ekle
    let detailScreen = self.storyboard?.instantiateViewController(withIdentifier: "detailScreen") as! DetailScreenViewController
    detailScreen.pokemon = DataManager.shared.pokemons[indexPath.row]
    detailScreen.pokemonDetail = DataManager.shared.pokemonDetails[DataManager.shared.pokemons[indexPath.row].name]
    detailScreen.title = DataManager.shared.pokemons[indexPath.row].name.capitalized
    self.navigationController?.pushViewController(detailScreen, animated: true)
  }
  
  //Created triggerIndex for understanding which cell displayed latest. If condition conforms then loadMorePokemon works.
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let triggerIndex = DataManager.shared.pokemons.count - 5
    if indexPath.row >= triggerIndex {
      loadMorePokemon()
    }
  }
}


