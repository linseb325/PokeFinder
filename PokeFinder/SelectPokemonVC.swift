//
//  SelectPokemonVC.swift
//  PokeFinder
//
//  Created by Brennan Linse on 6/20/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit

class SelectPokemonVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var mainScreenRef: MainVC!
    
    var filteredPokemon = [String]()
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
    }
    
    // COLLECTION VIEW METHODS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Prepare the cell
        var pokeNum: Int
        
        if inSearchMode {
            pokeNum = pokemon.index(of: filteredPokemon[indexPath.row])! + 1
        } else {
            pokeNum = indexPath.row + 1
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCVC", for: indexPath) as? PokeCVC {
            print("Right before configuring cell for pokemon number \(pokeNum)")
            cell.configureCell(pokeID: pokeNum)
            print("Successfully configured cell for pokemon number \(pokeNum)")
            return cell
        } else {
            print("Didn't dequeue a reusable PokeCVC cell")
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokeNum: Int
        
        if inSearchMode {
            pokeNum = pokemon.index(of: filteredPokemon[indexPath.row])! + 1
        } else {
            pokeNum = indexPath.row + 1
        }
        
        let loc = CLLocation(latitude: self.mainScreenRef.mapView.centerCoordinate.latitude, longitude: self.mainScreenRef.mapView.centerCoordinate.longitude)
        self.dismiss(animated: true) {
            self.mainScreenRef.createSighting(forLocation: loc, withPokemon: pokeNum)
        }
    }
    
    // SEARCH BAR STUFF
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Search bar text changed
        if (searchBar.text == nil || searchBar.text == "") {
            inSearchMode = false
            self.collectionView.reloadData()
            self.view.endEditing(true)
        } else {
            inSearchMode = true
            let lowercasedText = searchBar.text!.lowercased()
            self.filteredPokemon = pokemon.filter({$0.range(of: lowercasedText) != nil})
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
