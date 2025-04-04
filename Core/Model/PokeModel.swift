//
//  PokeModel.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 20.03.2025.
//

import Foundation

struct Results: Codable {
  let results: [Pokemon]
}

struct Pokemon: Codable {
  let name: String
  let url: String
}

// MARK: Detailed Pokemon Infos
struct PokemonDetail: Codable {
  let id: Int
  let name: String
  let sprites: Sprites
  let abilities: [PokemonAbilities]
  //let stats: [PokemonStats]
}

// MARK: Pokemon Images
struct Sprites: Codable, Hashable {
  let frontDefault: String?
  let backDefault: String?
  let backFemale: String?
  let backShiny: String?
  let backShinyFemale: String?
  let frontFemale: String?
  let frontShiny: String?
  //let other: OtherSprites?
  
  enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
    case frontFemale = "front_female"
    case backDefault = "back_default"
    case backShiny = "back_shiny"
    case backFemale = "back_female"
    case backShinyFemale = "back_shiny_female"
  }
}

// MARK: Abilities is a list, so we should to unwrap
struct PokemonAbilities: Codable {
  let ability: Abilities
}
// like this
struct Abilities: Codable {
  let name: String
  let url: String
}

struct PokemonStats: Codable {
  let baseStat: Int
  let effort: Int
  let stats: Stats
}

struct Stats: Codable {
  let name: String
  let url: String
}
