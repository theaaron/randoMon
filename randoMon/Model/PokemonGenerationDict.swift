//
//  PokemonGenerationDict.swift
//  randoMon
//
//  Created by aaron on 1/21/23.
//

import Foundation

struct PokemonGenerationDict: Codable {
    let name: String
    let pokemon_species: [PokemonSpeciesDict]
}
