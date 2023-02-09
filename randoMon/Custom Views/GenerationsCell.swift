//
//  GenerationsCell.swift
//  randoMon
//
//  Created by aaron on 1/21/23.
//

import UIKit

class GenerationsCell: UICollectionViewCell {
    static let reuseID = "genCell"
    let genTitle = UILabel()
    
    func set(gen: GenerationResults, genNumber: Int) {
        genTitle.text = "Generation " + String(genNumber)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
    
    func setupGenTitle() {
        addSubview(genTitle)
        genTitle.translatesAutoresizingMaskIntoConstraints = false
        genTitle.font = .systemFont(ofSize: 20, weight: .bold)
        genTitle.textAlignment = .center
        genTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        genTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        genTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        genTitle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        layer.cornerRadius = 14
        setupGenTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
