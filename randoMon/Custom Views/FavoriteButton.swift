//
//  FavoriteButton.swift
//  randoMon
//
//  Created by aaron on 2/8/23.
//

import UIKit

class FavoriteButton: UIButton {
    let unfilledHeart = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .large))
    
    let filledHeart = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .large))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        unfillHeart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillHeart() {
        setImage(filledHeart, for: .normal)
    }
    
    func unfillHeart() {
        setImage(unfilledHeart, for: .normal)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
