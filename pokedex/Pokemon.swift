//
//  Pokemon.swift
//  pokedexApp
//
//  Created by Aditya Parakh on 7/2/16.
//  Copyright © 2016 Aditya Parakh. All rights reserved.
//

import Foundation
import Alamofire

// POKEMON CLASS
// -- Explanations -- \\
/*
| This is the Pokemon class that will store each Pokemon's data. Only Name and pokedex ID are used
| The CSV file is parsed and then the data is imported in the screen to be used.
*/

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    private var _pokemonURL: String!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var _defense: String!
    private var _description: String!
    private var _type1: String!
    private var _type2 =  ""
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int{
        return _pokedexID
    }
    
    var type1: String{
        return _type1
    }
    
    var type2: String{
        return _type2
    }
    
    var weight: String{
        return _weight
    }
    
    var height: String{
        return _height
    }
    
    var attack: String{
        return _attack
    }
    
    var defense: String{
        return _defense
    }
    
    var description: String{
        return _description
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }
    
    // Downloading data from internet using POKEAPI
    
    func downloadPokemonDetails(completed: (poop: String) -> ()){
        
        // SETTING URL
        let url = NSURL(string: _pokemonURL)
        Alamofire.request(.GET, url!).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = String(attack)
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = String(defense)
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let type = types[0]["name"]{
                        self._type1 = type
                        POKEMON_TYPE_ONE = type
                    }
                    if types.count > 1{
                        if let type2 = types[1]["name"]{
                            self._type2 = type2
                            POKEMON_TYPE_TWO = type2
                        }
                    }
                }
                else{
                    self._type1 = ""
                    self._type2 = ""
                }
                
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"]{
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON{ response in
                            let descResult = response.result
                            
                            if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String{
                                    self._description = description
                                }
                            }
                            
                        }
                    }
                }
                
            }
            
            completed(poop: "hi")
        }
        
    }
 
}