//
//  PokedexTableCell.swift
//  randoMon
//
//  Created by aaron on 1/30/23.
//

import UIKit

class PokedexTableCell: UITableViewCell {
    static let reuseId = "DexCell"
    
    let pokeImageView = UIImageView()
    let pokeNameLabel = UILabel()
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    func set(pokeSpeciesUrl: PokemonSpeciesUrl) {
        Task {
            let pokeSpecies = await NetworkingManager.shared.getPokemonSpecies(url: pokeSpeciesUrl.url)
            let pokeObjUrl = NetworkingManager.allPokemon + String(pokeSpecies?.id ?? 1)
            let pokeObj = await NetworkingManager.shared.getPokemonObj(pkmnUrl: pokeObjUrl)
            let imageURL: URL = URL(string: pokeObj?.sprites.front_shiny ?? "")!
            pokeImageView.load(url: imageURL)
            pokeNameLabel.text = pokeSpecies?.name.capitalized
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        addSubview(pokeImageView)
        addSubview(pokeNameLabel)
        
        //setup image
        pokeImageView.translatesAutoresizingMaskIntoConstraints = false
        pokeImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        pokeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pokeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pokeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        //setup label
        pokeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokeNameLabel.leadingAnchor.constraint(equalTo: pokeImageView.trailingAnchor, constant: 20).isActive = true
        pokeNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
