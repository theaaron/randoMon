//
//  PokemonVC.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit

class PokemonVC: UIViewController {
    
    var pokemonObj: Pokemon?
    var pokemonSpeciesObj: PokemonSpecies?
    var pokemonUrl = ""
    let pokemonNameLabel = UILabel()
    let pokemonImageView = UIImageView()
    let pokemonTypesLabel = UILabel()
    let pokemonNumberLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        setUIWithPokemonObj()
    }
    
    func setUIWithPokemonObj() {
        Task {
            pokemonObj = await NetworkingManager.shared.getPokemonObj(pkmnUrl: pokemonUrl)
            pokemonSpeciesObj = await NetworkingManager.shared.getPokemonSpecies(url: pokemonObj?.species.url ?? "")
            self.setupNameLabel()
            self.setupPokeNumberLabel()
            self.setupPokemonImageView()
            self.setupPokemonTypesLabel()
        }
    }
    
    func addSubViews() {
        view.addSubview(pokemonNameLabel)
        view.addSubview(pokemonImageView)
        view.addSubview(pokemonTypesLabel)
        view.addSubview(pokemonNumberLabel)
    }
    
    func setupPokemonImageView() {
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        if let url = URL(string: pokemonObj?.sprites.front_default ?? "") {
            pokemonImageView.load(url: url)
        }
        
        pokemonImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        pokemonImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupNameLabel() {
        pokemonNameLabel.text = pokemonObj?.species.name.capitalized
        pokemonNameLabel.textAlignment = .center
        pokemonNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 10).isActive = true
        pokemonNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        pokemonNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupPokeNumberLabel() {
        let pokemonNumber: Int = pokemonSpeciesObj?.id ?? 9000
        pokemonNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNumberLabel.text = "Pokémon # \(String(pokemonNumber))"
        pokemonNumberLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        pokemonNumberLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 8).isActive = true
        pokemonNumberLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    

    
    func setupPokemonTypesLabel() {
        pokemonTypesLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypesLabel.text = "Type(s): \(changeTypesToString(typesArr: pokemonObj?.types ?? []))"
        pokemonTypesLabel.topAnchor.constraint(equalTo: pokemonNumberLabel.bottomAnchor, constant: 10).isActive = true
        pokemonTypesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        
        
    }
    
    func changeTypesToString(typesArr: [Types]) -> String {
        var typesString = ""
        for types in typesArr {
            if typesString.isEmpty {
                typesString += types.type.name.capitalized
            } else {
                typesString += " & \(types.type.name.capitalized)"
            }
        }
        return typesString
    }

}
