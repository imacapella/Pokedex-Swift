//
//  SpriteType.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 2.04.2025.
//

import Foundation

enum SpriteType: String, Codable, CaseIterable {
  case frontDefault
  case frontShiny
  case frontFemale
  case backDefault
  case backShiny
  case backFemale
  case backShinyFemale
  
  func isAvailable(in detail: PokemonDetail) -> Bool {
    switch self {
    case .backDefault: return detail.sprites.backDefault != nil
    case .backFemale: return detail.sprites.backFemale != nil
    case .backShiny: return detail.sprites.backShiny != nil
    case .backShinyFemale: return detail.sprites.backShinyFemale != nil
    case .frontDefault: return detail.sprites.frontDefault != nil
    case .frontFemale: return detail.sprites.frontFemale != nil
    case .frontShiny: return detail.sprites.frontShiny != nil
    }
  }
}
