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
    private var _evolutionID = ""
    private var _evolutionName = ""
    private var _evolutionLvl = ""
    private var _evolutionID2 = ""
    private var _evolutionName2 = ""
    private var _evolutionLvl2 = ""
    
    
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
    
    var evolutions: Array<String>{
        return [_evolutionLvl, _evolutionID, _evolutionName]
    }
    
    var evolution2: Array<String>{
        return [_evolutionLvl2, _evolutionID2, _evolutionName2]
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
                    self._weight = String(Double(weight)!/10)
                }
                if let height = dict["height"] as? String{
                    self._height = String(Double(height)!/10)
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
                
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>]
                    where evolutions.count > 0 {
                        if let to = evolutions[0]["to"] as? String{
                            
                            
                            if to.rangeOfString("mega") == nil{
                                
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._evolutionID = num
                                    self._evolutionName = to
                                    
                                    if let lvl = evolutions[0]["level"] as? Int{
                                        self._evolutionLvl = String(lvl)
                                        
                                        
                                    }
                                    
                                    let newPoke = "\(URL_BASE)\(uri)"
                                    
                                    print(newPoke)
                                    Alamofire.request(.GET, NSURL(string: newPoke)!).responseJSON {
                                        response in
                                        
                                        let result = response.result
                                        if let dict = result.value as? Dictionary<String, AnyObject>{
                                            if let evolution2 = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolution2.count > 0{
                                                if let to2 = evolution2[0]["to"] as? String{
                                                    if to2.rangeOfString("mega") == nil{
                                                        if let uri2 = evolution2[0]["resource_uri"] as? String{
                                                            let newStr2 = uri2.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                                            let num2 = newStr2.stringByReplacingOccurrencesOfString("/", withString: "")
                                                            self._evolutionID2 = num2
                                                            print(num2)
                                                            print(to2)
                                                            self._evolutionName2 = to2
                                                            if let lvl = evolution2[0]["level"] as? Int{
                                                                self._evolutionLvl2 = String(lvl)
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                            }

                                        }
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