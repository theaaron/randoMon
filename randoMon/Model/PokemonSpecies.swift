//
//  PokemonSpeciesDict.swift
//  randoMon
//
//  Created by aaron on 1/17/23.
//

import Foundation

struct PokemonSpeciesDict: Codable {
    let name: String
    let url: String
    
}

struct PokemonSpecies: Codable {
    let name: String
    let id: Int
    let varieties: [PokemonVariety]
}

struct PokemonVariety: Codable {
    let is_default: Bool
    let pokemon: PokemonBrief
}
