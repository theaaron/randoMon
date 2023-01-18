//
//  PokemonVC.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit

class PokemonVC: UIViewController {
    
    var pokemonObj: Pokemon?
    var pokemonUrl = ""
    let pokemonNameLabel = UILabel()
    let pokemonImageView = UIImageView()
    let pokemonTypesLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        DispatchQueue.main.async {
            self.setupNameLabel()
            self.setupPokemonImageView()
            self.setupPokemonTypesLabel()
        }
        
    }
    
    func addSubViews() {
        view.addSubview(pokemonNameLabel)
        view.addSubview(pokemonImageView)
        view.addSubview(pokemonTypesLabel)
    }
    
    func setupNameLabel() {
        pokemonNameLabel.text = pokemonObj?.species.name.capitalized
        pokemonNameLabel.textAlignment = .center
        pokemonNameLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 40).isActive = true
        pokemonNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        pokemonNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
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
    
    func setupPokemonTypesLabel() {
        pokemonTypesLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypesLabel.text = "Types: \(changeTypesToString(typesArr: pokemonObj?.types ?? []))"
        pokemonTypesLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 10).isActive = true
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
