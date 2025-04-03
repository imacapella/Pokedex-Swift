//  DataManager.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 27.03.2025.

import Foundation

final class DataManager {
  
  static let shared = DataManager()
  private init() {}
  
  var pokemons : [Pokemon] = []
  var pokemonDetails: [String : PokemonDetail] = [:]
  var spriteURLs:[String : [String : URL?]]  = [:]
}
