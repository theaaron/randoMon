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
    let flavor_text_entries: [FlavorTextEntry]
}

struct PokemonVariety: Codable {
    let is_default: Bool
    let pokemon: PokemonBrief
}

struct FlavorTextEntry: Codable {
    let flavor_text: String
    let language: PokemonLanguage
}

struct PokemonLanguage: Codable {
    let name: String
    let url: String
}
