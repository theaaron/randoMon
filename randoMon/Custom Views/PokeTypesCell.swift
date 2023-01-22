//
//  PokeTypesCell.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit

class PokeTypesCell: UICollectionViewCell {
    static let reuseId = "pokeTypeCell"
    
    let typeCellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(type: AllPokemonTypes) {
        typeCellLabel.text = type.name
    }
    
    func setupLabel() {
        addSubview(typeCellLabel)
        typeCellLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        typeCellLabel.translatesAutoresizingMaskIntoConstraints = false
        typeCellLabel.textAlignment = .center
        typeCellLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        typeCellLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        typeCellLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        typeCellLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        layer.cornerRadius = 12
    }
    
    
}
