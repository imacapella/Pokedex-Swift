//  ViewController.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 20.03.2025

import UIKit
import Kingfisher

class ViewController: UIViewController {
  
  @IBOutlet weak var pokemonTableView: UITableView!
  private var isFetching: Bool = false
  var pokemonAPI = PokemonAPI()                                   // PokemonAPI Object
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pokemonTableView.delegate = self
    pokemonTableView.dataSource = self
    if DataManager.shared.pokemons.isEmpty {
      fetchPokemons()
    }
  }
  
  //MARK: - API Calls
  //Get All Pokemons
  func fetchPokemons() {
    Task {
      do {
        let fetchedPokemons = try await pokemonAPI.fetchPokemons(offset: 0, limit: 21)
        DataManager.shared.pokemons = fetchedPokemons
        for pokemon in fetchedPokemons {
          let detail = try await pokemonAPI.fetchPokemonDetails(url: pokemon.url)
          DataManager.shared.pokemonDetails[pokemon.name] = detail
          //print(detail.stats)
          let seperatedSpriteURLs = seperateURLsFromSprites(detail)
          DataManager.shared.spriteURLs[pokemon.name] = seperatedSpriteURLs
        }
        DispatchQueue.main.async {                                    // Reload Table View
          self.pokemonTableView.reloadData()                          // Reload Table View
        }                                                             // Reload Table View
      } catch {                                                       // Reload Table View
        print("Error fetching Pokémon:", error)                       // Reload Table View
      }
    }
  }
  
  //Get More Pokemon for Pagination
  func loadMorePokemon() {
    guard !isFetching else { return }
    isFetching = true
    Task {
      do {
        let newPokemons = try await pokemonAPI.loadMorePokemon()
        DataManager.shared.pokemons += newPokemons
        
        for pokemon in newPokemons {                                                    // Get New Details
          let detail = try await pokemonAPI.fetchPokemonDetails(url: pokemon.url)   // Get New Details
          DataManager.shared.pokemonDetails[pokemon.name] = detail                      // Get New Details
          let newSeperatedSpriteURLs = seperateURLsFromSprites(detail)
          DataManager.shared.spriteURLs[pokemon.name] = newSeperatedSpriteURLs
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
  
  func seperateURLsFromSprites(_ pokemonDetail: PokemonDetail) -> [String : URL] {
    let spriteType = pokemonDetail.sprites
    var spritesDictionary: [String: URL] = [:]
    
    let spriteMappings: [(key: String, value: String?)] = [
      ("frontDefault", spriteType.frontDefault),
      ("backDefault", spriteType.backDefault),
      ("frontShiny", spriteType.frontShiny),
      ("backShiny", spriteType.backShiny),
      ("frontFemale", spriteType.frontFemale),
      ("backFemale", spriteType.backFemale),
      ("backShinyFemale", spriteType.backShinyFemale)
    ]
    for mapping in spriteMappings {
      if let urlString = mapping.value, let url = URL(string: urlString) {
        spritesDictionary[mapping.key] = url
      }
    }
    
    return spritesDictionary
  }
}

//MARK: - UITableViewDelegate, UITableViewDataSource Extensions
extension ViewController : UITableViewDelegate, UITableViewDataSource {
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Seçilen Pokémon:", DataManager.shared.pokemons[indexPath.row].name)
    
    // Yeni storyboard'u elle yükle
    let detailStoryboard = UIStoryboard(name: "DetailScreen", bundle: nil)
    
    // "detailScreen" kimliğine sahip View Controller'ı bu storyboard'dan çek
    let detailScreenVC = detailStoryboard.instantiateViewController(
      withIdentifier: "detailScreen"
    ) as! DetailScreenViewController
    
    // Verileri aktar
    detailScreenVC.pokemon = DataManager.shared.pokemons[indexPath.row]
    detailScreenVC.pokemonDetail = DataManager.shared.pokemonDetails[DataManager.shared.pokemons[indexPath.row].name]
    detailScreenVC.title = DataManager.shared.pokemons[indexPath.row].name.capitalized
    
    // Navigation Controller varsa push et
    self.navigationController?.pushViewController(detailScreenVC, animated: true)
  }
  
  
  //Created triggerIndex for understanding which cell displayed latest. If condition conforms then loadMorePokemon works.
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let triggerIndex = DataManager.shared.pokemons.count - 5
    if indexPath.row >= triggerIndex {
      loadMorePokemon()
    }
  }
}


