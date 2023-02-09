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
    
//    func deleteAll() {
//        do {
//            try! realm.write({
//                realm.deleteAll()
//            })
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFavsCollectionView()
        DispatchQueue.main.async {
            self.favsCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favsCollectionView.reloadData()
    }
    
    func addToFavs() {
        let poke = FavoritePokemonCard()
        poke.name = "Charmander"
        poke.imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png"
        do {
            try realm.write({
                realm.add(poke)
            })
        } catch {
            print("error")
        }
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
