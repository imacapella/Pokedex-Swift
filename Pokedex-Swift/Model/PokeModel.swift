//
//  PokeModel.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 20.03.2025.
//

import Foundation

struct PokeResult: Codable {
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
    let sprites: PokeSprites
    let abilities: [PokeAbilities]
}

// MARK: Pokemon Images
struct PokeSprites: Codable {
    let frontDefault: String
    //let other: OtherSprites?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: Abilities is a list, so we should to unwrap
struct PokeAbilities: Codable {
    let ability: Abilities
}
// like this
struct Abilities: Codable{
    let name: String
    let url: String
}
