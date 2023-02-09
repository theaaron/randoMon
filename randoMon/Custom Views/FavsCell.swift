//
//  CollectionViewCell.swift
//  randoMon
//
//  Created by aaron on 2/8/23.
//

import UIKit

class FavsCell: UICollectionViewCell {
    static let reuseId = "FavsCell"
    let nameLabel = UILabel()
    let pokePhoto = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        layer.cornerRadius = 12
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favCard: FavoritePokemonCard) {
        nameLabel.text = favCard.name.capitalized
        if let url = URL(string: favCard.imageUrl) {
            pokePhoto.load(url: url)
        }
        
    }
    
    func setupCell() {
        addSubview(pokePhoto)
        addSubview(nameLabel)
        
        setupLabel()
        setUpImage()
    }
    
    func setupLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    func setUpImage() {
        pokePhoto.translatesAutoresizingMaskIntoConstraints = false
        pokePhoto.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pokePhoto.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pokePhoto.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        pokePhoto.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    
}
