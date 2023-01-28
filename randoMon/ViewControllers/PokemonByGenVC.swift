//
//  PokemonByTypeVC.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit

class PokemonByGenVC: UIViewController {
    var generations: [GenerationResults] = []
    var genCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        getAllGens()
        setupCollectionView()
        setupGenTableView()
        print(generations)
    }
    
    func setupCollectionView() {
        genCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: makeSingleColumnFlowLayout())
        genCollectionView.delegate = self
        genCollectionView.dataSource = self
        genCollectionView.register(GenerationsCell.self, forCellWithReuseIdentifier: GenerationsCell.reuseID)
        
    }
    
    func setupGenTableView() {
        view.addSubview(genCollectionView)
        genCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        genCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        genCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        genCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        genCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    func getAllGens() {
        Task {
            let gens = await NetworkingManager.shared.getAllPokemonGens()
            generations.append(contentsOf: gens!)
            print(generations)
            genCollectionView.reloadData()
        }
    }
    
}

extension PokemonByGenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return generations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genCollectionView.dequeueReusableCell(withReuseIdentifier: GenerationsCell.reuseID, for: indexPath) as! GenerationsCell
        let gen = generations[indexPath.row]
        cell.set(gen: gen, genNumber: indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = PokemonVC()
        Task {
            let genPokemonArr = await NetworkingManager.shared.getPokemonByGen(genNumber: String(indexPath.row + 1))
            let pokeSpecUrl = genPokemonArr.randomElement()?.url ?? ""
            let pokeSpec = await NetworkingManager.shared.getPokemonSpecies(url: pokeSpecUrl)
            let pokeUrl = pokeSpec?.varieties[0].pokemon.url
            destVC.pokemonUrl = pokeUrl ?? ""
            print(destVC.pokemonUrl)
            present(destVC, animated: true)
        }
    }
    
    
    func makeSingleColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 20
        let availableWidth = width - (padding * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: availableWidth, height: 150)
        flowLayout.minimumLineSpacing = padding
        
        return flowLayout
    }
    
}
