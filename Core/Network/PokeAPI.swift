//
//  PokeAPI.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 20.03.2025.
//

import Foundation

class PokemonAPI {
    private let resultsUrl = "https://pokeapi.co/api/v2/pokemon?limit=24"
    // Pokémon verileri
    var pokemons: [Pokemon] = []
    
    // Detay verileri
    var pokemonDetails: [PokemonDetail] = []
    
    // Pokémonları çekmek için fonksiyon
    func fetchPokemons(offset: Int, limit: Int) async throws {
        let urlString = "https://pokeapi.co/api/v2/pokemon"
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        guard let url = components.url else { return }
        
        //URLSession
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Results.self, from: data)
        self.pokemons = response.results 
    }
    
    // Pokemon Details
    func fetchPokemonDetails(url: String) async throws -> PokemonDetail {
        guard let url = URL(string: url) else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemonDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
        
        return pokemonDetail
    }
  
  func getAllInformations() async throws -> [PokemonDetail] {
    var allPokemonDetails: [PokemonDetail] = []
    for pokemon in pokemons {
      let detail = try await fetchPokemonDetails(url: pokemon.url)
      allPokemonDetails.append(detail)
    }
    return allPokemonDetails
  }
  
}













/*
 
 func fetchPokemons() {
     guard let url = URL(string: resultsUrl) else { return }

     URLSession.shared.dataTask(with: url) { data, response, error in
         if let error = error {
             print("Hata oluştu: \(error.localizedDescription)")
             return
         }

         guard let data = data else { return }

         do {
             let pokemonFetchResult = try JSONDecoder().decode(PokeResult.self, from: data)
         } catch {
             print("JSON parse hatası: \(error.localizedDescription)")
         }
     }.resume()
 }
 
 */
