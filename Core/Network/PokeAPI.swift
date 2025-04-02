//  PokeAPI.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 20.03.2025.

import Foundation

class PokemonAPI {
  private var currentOffset: Int = 0
  private var offset: Int = 0                                         // Offset Value for API
  private var limit: Int = 21                                         // Limit Value for API
  private let urlString = "https://pokeapi.co/api/v2/pokemon"
  
  // Pokémonları çekmek için fonksiyon
  func fetchPokemons(offset: Int, limit: Int) async throws -> [Pokemon] {
    
    var components = URLComponents(string: urlString)!
    components.queryItems = [
      URLQueryItem(name: "offset", value: "\(offset)"),
      URLQueryItem(name: "limit", value: "\(limit)")
    ]
    guard let url = components.url else { return [] }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode(Results.self, from: data)
    
    return response.results
  }
  
  // Pokemon Details
  func fetchPokemonDetails(url: String) async throws ->  PokemonDetail {
    guard let url = URL(string: url) else {
      throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
    
    return pokemonDetail
  }
  
  //The function works for pagination.
  func loadMorePokemon() async throws -> [Pokemon] {
    let newOffset = currentOffset + limit
    let newPokemons = try await fetchPokemons(offset: newOffset, limit: limit)
    currentOffset = newOffset
    
    return newPokemons
  }
  
  func getPokemonSprites(url: String) async throws -> Sprites {
    guard let url = URL(string:  url) else {
      throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let pokemonImages = try JSONDecoder().decode(Sprites.self, from: data)
    
    print(pokemonImages)
    return pokemonImages
  }
}
