//
//  FavPokemonVC.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit
import RealmSwift

class FavPokemonVC: UIViewController {

    let realm = try! Realm()
    
    var favsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavsCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favsCollectionView.reloadData()
    }
    

    
    func setupFavsCollectionView() {
        favsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: makeTwoColumnFlowLayout())
        view.addSubview(favsCollectionView)
        favsCollectionView.delegate = self
        favsCollectionView.dataSource = self
        favsCollectionView.register(FavsCell.self, forCellWithReuseIdentifier: FavsCell.reuseId)
        
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

}

extension FavPokemonVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realm.objects(FavoritePokemonCard.self).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favsCollectionView.dequeueReusableCell(withReuseIdentifier: FavsCell.reuseId, for: indexPath) as! FavsCell
        let favCard = realm.objects(FavoritePokemonCard.self)[indexPath.row]
        cell.set(favCard: favCard)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = PokemonVC()
        let pokes = realm.objects(FavoritePokemonCard.self)
        destVC.pokemonUrl = pokes[indexPath.row].pokeObjUrl
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
}
