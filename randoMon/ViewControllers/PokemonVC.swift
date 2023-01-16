//
//  PokemonVC.swift
//  randoMon
//
//  Created by aaron on 1/15/23.
//

import UIKit

class PokemonVC: UIViewController {
    
    let pokemonNameLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        setupNameLabel()
    }
    
    func addSubViews() {
        view.addSubview(pokemonNameLabel)
    }
    
    func setupNameLabel() {
        pokemonNameLabel.textAlignment = .center
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        pokemonNameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        
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
