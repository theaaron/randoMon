//
//  PokedexVC.swift
//  randoMon
//
//  Created by aaron on 1/30/23.
//

import UIKit

class PokedexVC: UIViewController {
    
    var pokemonDexList: AllPokemonSpecies?
    
    let pokeDexTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            pokemonDexList = await NetworkingManager.shared.getAllPokemonSpecies()
            setupPokedexTableView()
        }
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func setupPokedexTableView() {
        view.addSubview(pokeDexTableView)
        
        pokeDexTableView.delegate = self
        pokeDexTableView.dataSource = self
        
        pokeDexTableView.rowHeight = 120
        pokeDexTableView.register(PokedexTableCell.self, forCellReuseIdentifier: PokedexTableCell.reuseId)
        pokeDexTableView.translatesAutoresizingMaskIntoConstraints = false
        pokeDexTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pokeDexTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pokeDexTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pokeDexTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    func createPokemonList() {
        
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

extension PokedexVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonDexList?.results.count ?? 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokeDexTableView.dequeueReusableCell(withIdentifier: PokedexTableCell.reuseId, for: indexPath) as! PokedexTableCell
        guard let poke = pokemonDexList?.results[indexPath.row] else {
            return cell
        }
        cell.set(pokeSpeciesUrl: poke)
        return cell
    }
}
