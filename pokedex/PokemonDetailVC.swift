//
//  PokemonDetailVC.swift
//  pokedexApp
//
//  Created by Aditya Parakh on 7/4/16.
//  Copyright © 2016 Aditya Parakh. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var type2: UIImageView!
    @IBOutlet weak var type1: UIImageView!
    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var typeONEONLYview: UIView!
    @IBOutlet weak var typeTWOview: UIStackView!
    @IBOutlet weak var typeSingle: UIImageView!
    
    override func viewDidLoad() {  
        super.viewDidLoad()

        lblText.text = pokemon.name
        pokemonImg.image = UIImage(named: String(pokemon.pokedexID))
        // Do any additional setup after loading the view.
        pokedexID.text = returnPokedex(pokemon.pokedexID)
        print(self.pokemon.type1)
        
        if pokemon.type2 != ""{
            type1.image = UIImage(named: pokemon.type1)
            type2.image = UIImage(named: pokemon.type2)
        }
        else{
            typeONEONLYview.hidden = false
            typeTWOview.hidden = true
            typeSingle.image = UIImage(named: pokemon.type1)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnPokedex(id: Int) -> String{
        let length = String(id).characters.count
        var returnVal: String!
        if length == 1 {
            returnVal = "#00\(id)"
        }
        else if length == 2{
            returnVal = "#0\(id)"
        }
        else{
            returnVal = "#\(id)"
        }
        POKEMON_ID_STRING = returnVal
        return returnVal
    }
    
    @IBAction func moreInformation(sender: AnyObject) {
        self.performSegueWithIdentifier("PokemonMoreInfoVC", sender: pokemon)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonMoreInfoVC" {
            if let detailsVC = segue.destinationViewController as? PokemonMoreInfoViewController {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = pokemon
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
