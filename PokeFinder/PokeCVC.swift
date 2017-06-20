//
//  PokeCVC.swift
//  PokeFinder
//
//  Created by Brennan Linse on 6/20/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit

class PokeCVC: UICollectionViewCell {
    
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    
    
    
    func configureCell(pokeID: Int) {
        self.pokeNameLabel.text = pokemon[pokeID-1].capitalized
        self.pokeImage.image = UIImage(named: "\(pokeID)")
    }
    
    
    
    
    
    
    
    
    
    
}
