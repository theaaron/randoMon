//
//  NetworkingManager.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit

struct NetworkingManager {
    
    static let shared = NetworkingManager()
    
    static let allPokemon = "https://pokeapi.co/api/v2/pokemon/"
    let allPokemonSpecies = "https://pokeapi.co/api/v2/pokemon-species"
    let typePokemon = "https://pokeapi.co/api/v2/type/"
    let genPokemon = "https://pokeapi.co/api/v2/generation/"
    
    
    //getting list of pokemon species
    func getAllPokemonSpecies() async -> AllPokemonSpecies? {
        guard let url = URL(string: allPokemonSpecies) else {
            print("error with the url")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let allPkmn = try JSONDecoder().decode(AllPokemonSpecies.self, from: data)
            return allPkmn
        } catch {
            print("error creating object.")
            return nil
        }
        
    }
    
    
    //Getting types
    
    func getTypes(completed: @escaping (PokemonTypesDict?, String?) -> Void) {
        guard let url = URL(string: typePokemon) else {
            print("problem with the url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, String(describing: error))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "not 200")
                return
            }
            guard let data = data else {
                completed(nil, "there was no data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedTypes = try decoder.decode(PokemonTypesDict.self, from: data)
                completed(decodedTypes, nil)
            } catch {
                completed(nil, "unable to decode the JSON")
            }
        }
        task.resume()
    }
    
    func getPokemonFromTypesList(baseUrl: String, completed: @escaping (PokemonByTypeDict?, String?) -> Void) {
        guard let url = URL(string: baseUrl) else {
            print("problem with the url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "Error: \(String(describing: error))")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "did not receive 200 status code")
                return
            }
            guard let data = data else {
                completed(nil, "did not receive data.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokeByTypeDict = try decoder.decode(PokemonByTypeDict.self, from: data)
                completed(pokeByTypeDict, nil)
            } catch {
                completed(nil, "Unable to decode JSON")
            }
        }
        task.resume()
    }
    
    func getPokemonOfType(typeUrl: String) async -> [PokemonDict] {
        let url = URL(string: typeUrl)
        guard let url = url else {
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pkmn = try JSONDecoder().decode(PokemonByTypeDict.self, from: data)
            return pkmn.pokemon
        } catch {
            return []
        }
    }
    
    //Getting gens and pokemon by gens
    
    func getAllPokemonGens() async -> [GenerationResults]? {
        let url = URL(string: genPokemon)
        guard let url = url else {
            print("invalid url")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let allGens = try JSONDecoder().decode(ListOfGenerations.self, from: data)
            return allGens.results
        } catch {
            print("could not decode data for generation list")
            return []
        }
        
    }
    
    func getPokemonByGen(genNumber: String) async -> [PokemonSpeciesUrl] {
        let url = URL(string: genPokemon + genNumber)
        guard let url = url else {
            print("invalid url")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let genInfo = try JSONDecoder().decode(GenerationInfo.self, from: data)
            let genPokes = genInfo.pokemon_species
            return genPokes
        } catch {
            return []
        }
    }
    
    // getting Pokemon objects
    
    func getPokemonObj(pkmnUrl: String) async -> Pokemon? {
        let url = URL(string: pkmnUrl)
        guard let url = url else {
            print("invalid url")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pkmnObj = try JSONDecoder().decode(Pokemon.self, from: data)
            return pkmnObj
        } catch {
            print("error decoding pokemon: \(error)")
            return nil
        }
    }
    
    func getPokemonSpecies(url: String) async -> PokemonSpecies? {
        guard let pokeUrl = URL(string: url) else {
            print("invalid url")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: pokeUrl)
            let pokeSpecies = try JSONDecoder().decode(PokemonSpecies.self, from: data)
            return pokeSpecies
        } catch {
            print("error creating the PokemonSpecies object")
            return nil
        }
    }
    
    //getting properties for creating a card.
    
    func getPokemonDetailCard(pkmnUrl: String, pkmnSpecUrl: String) async -> PokemonDetailsCard {
        let pokemonObj = await getPokemonObj(pkmnUrl: pkmnUrl)
        let pokemonSpecies = await getPokemonSpecies(url: pkmnSpecUrl)
        return PokemonDetailsCard(name: pokemonObj?.species.name ?? "missingNo",
                                  number: pokemonSpecies?.id ?? 0,
                                  types: pokemonObj?.types ?? [],
                                  frontSprite: pokemonObj?.sprites.front_default ?? "",
                                  shinyFrontSprite: pokemonObj?.sprites.front_shiny ?? "", flavorText: pokemonSpecies?.flavor_text_entries.filter({ flavorText in
            flavorText.language.name == "en"
        }) ?? [],
                                  varieties: pokemonSpecies?.varieties ?? [])
    }
    
    
    
}
