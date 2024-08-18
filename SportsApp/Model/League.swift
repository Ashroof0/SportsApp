//
//  League.swift
//  SportsApp
//
//  Created by Enas Mohamed on 17/08/2024.
//

import Foundation
struct Event{
    var name : String
    var date : String
    var time : String
    var homeTeamScore : Int
    var awayTeamScore : Int
    var homeTeamId : String
    var awayTeamId : String
}

enum EventState{
    case UPCOMING
    case PAST
}

struct Team{
    var id : String
    var name : String
    var badge : String
    var tshirt: String
    var foundYear: String
    var country: String
    var stadium: String
    var stadiumName: String
    var youtube : String
    var facebook : String
    var website : String
}

struct League{
    var id : String
    var name : String
    var badge : String
    var youtube : String
}
