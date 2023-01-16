//
//  NetworkingManager.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import Foundation

struct NetworkingManager {
    
    static let shared = NetworkingManager()
    
    let allPokemon = "https://pokeapi.co/api/v2/pokemon/"
    let typePokemon = "https://pokeapi.co/api/v2/type/"
    
    
    func getPokemon(baseUrl: String, completed: @escaping (PokemonByTypeDict?, String?) -> Void) {
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
    
}
