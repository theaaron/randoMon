//
//  PokemonVC.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit
import RealmSwift

class PokemonVC: UIViewController {
    
    var realm = try! Realm()
    var pokemonObj: Pokemon?
    var pokemonDetailsCard: PokemonDetailsCard?
    var pokemonUrl = ""
    let pokemonNameLabel = UILabel()
    let pokemonImageView = UIImageView()
    let pokemonTypesLabel = UILabel()
    let pokemonNumberLabel = UILabel()
    let pokemonFlavorTextLabel = UILabel()
    let favButton = FavoriteButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        setUIWithPokemonObj()
    }
    
    func setUIWithPokemonObj() {
        Task {
            pokemonObj = await NetworkingManager.shared.getPokemonObj(pkmnUrl: pokemonUrl)
            pokemonDetailsCard = await NetworkingManager.shared.getPokemonDetailCard(pkmnUrl: pokemonUrl, pkmnSpecUrl: pokemonObj?.species.url ?? "")
            
            self.setupNameLabel()
            self.setupPokeNumberLabel()
            self.setupPokemonImageView()
            self.setupPokemonTypesLabel()
            self.setupPokemonFlavorTextLabel()
            self.setupFavButton()
        }
    }
    
    func addSubViews() {
        view.addSubview(pokemonNameLabel)
        view.addSubview(pokemonImageView)
        view.addSubview(pokemonTypesLabel)
        view.addSubview(pokemonNumberLabel)
        view.addSubview(pokemonFlavorTextLabel)
        view.addSubview(favButton)
    }
    
    func setupPokemonImageView() {
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        if let url = URL(string: pokemonDetailsCard?.shinyFrontSprite ?? "") {
            print(url)
            pokemonImageView.load(url: url)
        }
        
        pokemonImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        pokemonImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupNameLabel() {
        pokemonNameLabel.text = pokemonDetailsCard?.name.capitalized
        pokemonNameLabel.textAlignment = .center
        pokemonNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 10).isActive = true
        pokemonNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        pokemonNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
    }
    
    func setupPokeNumberLabel() {
        let pokemonNumber: Int = pokemonDetailsCard?.number ?? 9000
        pokemonNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNumberLabel.text = "Pokémon # \(String(pokemonNumber))"
        pokemonNumberLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        pokemonNumberLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: 8).isActive = true
        pokemonNumberLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    func setupPokemonTypesLabel() {
        pokemonTypesLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypesLabel.text = "Type(s): \(changeTypesToString(typesArr: pokemonDetailsCard?.types ?? []))"
        pokemonTypesLabel.topAnchor.constraint(equalTo: pokemonNumberLabel.bottomAnchor, constant: 10).isActive = true
        pokemonTypesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupPokemonFlavorTextLabel() {
        pokemonFlavorTextLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonFlavorTextLabel.numberOfLines = 0
        pokemonFlavorTextLabel.text = pokemonDetailsCard?.flavorText.randomElement()?.flavor_text
        pokemonFlavorTextLabel.textAlignment = .center
        pokemonFlavorTextLabel.topAnchor.constraint(equalTo: pokemonTypesLabel.bottomAnchor, constant: 20).isActive = true
        pokemonFlavorTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        pokemonFlavorTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
    
    func setupFavButton() {
        let favs = realm.objects(FavoritePokemonCard.self)
        if favs.contains(where: { favPokeCard in
            favPokeCard.number == pokemonDetailsCard?.number
        }) {
            favButton.fillHeart()
        } else {
            favButton.unfillHeart()
        }
        
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.addTarget(self, action: #selector(favButtonClicked), for: .touchUpInside)
        
        favButton.topAnchor.constraint(equalTo: pokemonNameLabel.topAnchor).isActive = true
        favButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        favButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
    
    @objc func favButtonClicked() {
        let favPokes = realm.objects(FavoritePokemonCard.self)
        if favPokes.contains(where: { favPoke in
            favPoke.number == pokemonDetailsCard?.number
        }) {
            if let favPoke = favPokes.first { $0.number == pokemonDetailsCard?.number} {
                try! realm.write {
                    realm.delete(favPoke)
                }
            }
            favButton.unfillHeart()
        } else {
            let poke = FavoritePokemonCard()
            poke.number = pokemonDetailsCard?.number ?? 0
            poke.name = pokemonDetailsCard?.name ?? ""
            poke.imageUrl = pokemonDetailsCard?.frontSprite ?? ""
            poke.shinyImageUrl = pokemonDetailsCard?.shinyFrontSprite ?? ""
            poke.pokeObjUrl = pokemonUrl
            
            
            try! realm.write {
                realm.add(poke)
            }
            favButton.fillHeart()
        }
        
        
    }

}
