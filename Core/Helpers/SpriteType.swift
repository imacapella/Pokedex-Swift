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
}
