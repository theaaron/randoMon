//
//  PokemonTypesDict.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import Foundation

struct PokemonTypesDict: Codable {
    let results: [AllPokemonTypes]
}

struct AllPokemonTypes: Codable {
    let name: String
    let url: String
}
