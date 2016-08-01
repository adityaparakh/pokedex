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
    @IBOutlet weak var pokemonPhoto: UIImageView!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var firstEvol: UIImageView!
    @IBOutlet weak var secondEvol: UIImageView!
    @IBOutlet weak var secondEvolname: UILabel!
    @IBOutlet weak var firstEvolName: UILabel!
    @IBOutlet weak var oneEvolution: UIStackView!
    @IBOutlet weak var twoEvolution: UIStackView!
    
    @IBOutlet weak var noevolution: UILabel!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonName.text = pokemon.name.capitalizedString
        pokedexID.text = POKEMON_ID_STRING
        pokemonDescription.text = pokemon.description
        height.text = pokemon.height + " m"
        weight.text = pokemon.weight + " kg"
        defense.text = pokemon.defense
        attack.text = pokemon.attack
        pokemonPhoto.image = UIImage(named:String(pokemon.pokedexID))
        // Do any additional setup after loading the view.
        
        var one = false
        var two = false
        if pokemon.evolutions[0] != "" {
            one = true
            print(pokemon.evolutions[1])
            if pokemon.evolution2[0] != "" {
                two = true
                print(pokemon.evolution2[1])
            }
        }
        
        if one && two{
            firstEvol.image = UIImage(named: pokemon.evolutions[1])
            firstEvolName.text = pokemon.evolutions[2].capitalizedString
            secondEvol.image = UIImage(named: pokemon.evolution2[1])
            secondEvolname.text = pokemon.evolution2[2].capitalizedString
        }
        
        if one == true && two == false{
            // set only first pokemon
            twoEvolution.hidden = true
            oneEvolution.hidden = false
        }
        
        if !one && !two{
            // no evolutions
            twoEvolution.hidden = true
            noevolution.hidden = false
        }
        
        
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
