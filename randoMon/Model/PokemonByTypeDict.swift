//
//  PokemonByTypeDict.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import Foundation

struct PokemonByTypeDict: Codable {
    let name: String
    let pokemon: [PokemonDict]
    
}

struct PokemonDict: Codable {
    let pokemon: PokemonBrief
    let slot: Int
}

struct PokemonBrief: Codable {
    let name: String
    let url: String
}
