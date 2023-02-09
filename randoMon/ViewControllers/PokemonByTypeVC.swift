//
//  PokemonByGenVC.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit
import RealmSwift

class PokemonByTypeVC: UIViewController {


    var typeCollectionView: UICollectionView!
    var allTypes: [AllPokemonTypes] = []
    let missingNo: Pokemon = Pokemon(name: "missingno", height: 76, weight: 55, sprites: Sprites(front_default: "", front_shiny: ""), types: [], species: PokemonSpeciesUrl(name: "missingno", url: ""))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        view.backgroundColor = .systemBackground
        getAllTypes()
        configCollectionView()
    }
    
    func getAllTypes() {
           NetworkingManager.shared.getTypes { pokeTypesDict, errorMsg in
               guard let pokeTypesDict = pokeTypesDict else {
                   print(errorMsg ?? "error")
                   return
               }
               self.allTypes.append(contentsOf: pokeTypesDict.results)
               self.allTypes.popLast()
               self.allTypes.popLast()
               DispatchQueue.main.async {
                   self.typeCollectionView.reloadData()
               }
           }
       }
       
       func configCollectionView() {
           typeCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: makeTwoColumnFlowLayout())
           view.addSubview(typeCollectionView)
           setDelegates()
           typeCollectionView.register(PokeTypesCell.self, forCellWithReuseIdentifier: PokeTypesCell.reuseId)
           
       }
       
       func makeTwoColumnFlowLayout() -> UICollectionViewFlowLayout {
           let width = view.bounds.width
           let padding: CGFloat = 20
           let cellSpacing: CGFloat = 20
           let availableWidth = width - (padding * 2) - cellSpacing
           let cellWidth = availableWidth / 2
           
           let flowLayout = UICollectionViewFlowLayout()
           flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
           flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
           flowLayout.minimumLineSpacing = padding
           
           return flowLayout
       }
       
       func setDelegates() {
           typeCollectionView.delegate = self
           typeCollectionView.dataSource = self
       }
}

extension PokemonByTypeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = typeCollectionView.dequeueReusableCell(withReuseIdentifier: PokeTypesCell.reuseId, for: indexPath) as! PokeTypesCell
        let type = allTypes[indexPath.row]
        cell.set(type: type)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = PokemonVC()
        let newUrl = allTypes[indexPath.row].url
        
        getRandomPokemon(typeUrl: newUrl, destVC: destVC)
    }
    
    
    func getRandomPokemon(typeUrl: String, destVC: PokemonVC) {
        Task {
            let pkmn = await NetworkingManager.shared.getPokemonOfType(typeUrl: typeUrl)
            let randomPkmn = pkmn.randomElement()?.pokemon
            let pokeObjUrl = randomPkmn?.url
            
            destVC.pokemonUrl = pokeObjUrl ?? ""
            present(destVC, animated: true)
        }
    }
    
    
    
}
