//
//  Events.swift
//  SportsApp
//
//  Created by Aziza on 01/05/2022.
//

import UIKit



class AllResult : Codable{
    let events : [Results]
}
class Results: Codable {
    
    let strHomeTeam: String?
    let strAwayTeam: String?
    let intHomeScore: String?
    let intAwayScore: String?
    
    let dateEvent: String?
    let strTime: String?
    
    
}
