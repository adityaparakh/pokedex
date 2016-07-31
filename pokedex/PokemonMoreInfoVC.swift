//
//  PokemonMoreInfoViewController.swift
//  pokedex
//
//  Created by Aditya Parakh on 7/29/16.
//  Copyright © 2016 Aditya Parakh. All rights reserved.
//

import UIKit

class PokemonMoreInfoViewController: UIViewController {

    @IBOutlet weak var pokedexID: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var pokemonPhoto: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pokemon.name)
        pokemonName.text = pokemon.name.capitalizedString
        pokedexID.text = POKEMON_ID_STRING
        pokemonDescription.text = pokemon.description
        height.text = pokemon.height
        weight.text = pokemon.weight
        defense.text = pokemon.defense
        attack.text = pokemon.attack
        pokemonPhoto.image = UIImage(named:String(pokemon.pokedexID))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
