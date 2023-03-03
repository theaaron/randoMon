//
//  PokemonGenerationDict.swift
//  randoMon
//
//  Created by aaron on 1/21/23.
//

import Foundation

struct ListOfGenerations: Codable {
    let generationsArray: [GenerationResults]
    
    enum CodingKeys: String, CodingKey {
        case generationsArray = "results"
    }
    
    
}

struct GenerationResults: Codable {
    let generationNumber: String
    let generationUrl: String
    
    enum CodingKeys: String, CodingKey {
        case generationNumber = "name"
        case generationUrl = "url"
    }
}

struct GenerationPokemon: Codable {
    let id: Int
    let pokemonSpecies: [PokemonSpeciesUrl]
}
