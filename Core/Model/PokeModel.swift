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
    let sprites: PokemonImages
    let abilities: [PokemonAbilities]
}

// MARK: Pokemon Images
struct PokemonImages: Codable {
    let frontDefault: String
    //let other: OtherSprites?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: Abilities is a list, so we should to unwrap
struct PokemonAbilities: Codable {
    let ability: Abilities
}
// like this
struct Abilities: Codable{
    let name: String
    let url: String
}
