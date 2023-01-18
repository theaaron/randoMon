//
//  Pokemon.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [Types]
    let species: PokemonSpeciesDict
}

struct Sprites: Codable {
    let front_default: String
    let front_shiny: String
}

struct Types: Codable {
    let slot: Int
    let type: Type
}

struct Type: Codable {
    let name: String
    let url: String
}
