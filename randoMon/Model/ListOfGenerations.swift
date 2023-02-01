//
//  PokemonGenerationDict.swift
//  randoMon
//
//  Created by aaron on 1/21/23.
//

import Foundation

struct ListOfGenerations: Codable {
    let results: [GenerationResults]
}

struct GenerationResults: Codable {
    let name: String
    let url: String
}

struct GenerationInfo: Codable {
    let id: Int
    let pokemon_species: [PokemonSpeciesUrl]
}
