//
//  ViewController.swift
//  pokedex
//
//  Created by Aditya Parakh on 7/4/16.
//  Copyright © 2016 Aditya Parakh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var inSearchMode = false
    var filteredPokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchbar.delegate = self
        searchbar.returnKeyType = UIReturnKeyType.Done
        parsePokemonCSV()
    }
    
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let pokeName = row["identifier"]!
                let poke = Pokemon(name: pokeName, pokedexID: pokeID)
                pokemon.append(poke)
            }
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    // COLLECTION VIEW FUNCTION START
    // -- Explanations -- \\
    /*
    | This function is called to make each cell of the Pokemon. The names are automatically assigned by
    | the csv file. pokedexID uses the ID received from the indexPath. row which returns an Int and
    | then it gets the image and displays it on the screen.
    */
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            
            let poke: Pokemon!
            
            if inSearchMode{
                poke = filteredPokemon[indexPath.row]
            }else{
                poke = pokemon[indexPath.row
                ]
            }
            cell.configureCell(poke)
            return cell
        } else{
            return UICollectionViewCell()
        }
    }
    
    // COLLECTION VIEW FUNCTION END
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poke: Pokemon!
        
        if inSearchMode{
            poke = filteredPokemon[indexPath.row]
        } else{
            poke = pokemon[indexPath.row]
        }

        let alert = UIAlertController(title: nil, message: "Loading Data...", preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        presentViewController(alert, animated: true, completion: nil)
        
        poke.downloadPokemonDetails { (poop) in
            
                            alert.dismissViewControllerAnimated(true, completion: {
                    self.performSegueWithIdentifier("PokemonDetailVC", sender: poke)
                    print(poop)
                })
            
            
            
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width / 3.75
        //print(screenWidth)
        return CGSizeMake(screenWidth, screenWidth)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchbar.text == nil || searchbar.text == ""{
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchbar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    @IBAction func unwindToViewControllerNameHere(segue: UIStoryboardSegue) {
        //nothing goes here
    }
    
    

}

