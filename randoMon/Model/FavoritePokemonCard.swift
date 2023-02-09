//
//  FavoritePokemonCard.swift
//  randoMon
//
//  Created by aaron on 2/8/23.
//

import Foundation
import RealmSwift

class FavoritePokemonCard: Object {
    @Persisted var name = ""
    @Persisted var number = 0
    @Persisted var flavorText = ""
    @Persisted var imageUrl = ""
    @Persisted var shinyImageUrl = ""
    @Persisted var types = ""
    @Persisted var pokeObjUrl = ""
}
