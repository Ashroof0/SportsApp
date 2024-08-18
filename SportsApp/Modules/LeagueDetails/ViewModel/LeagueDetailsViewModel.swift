//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Enas Mohamed on 13/08/2024.
//

import Foundation
// logic  - func call 
class LeagueDetailsViewModel {
    
    var sport : SportType?
    var idLeague : Int?
    var league : Leagues!
    var upcomingEvents: [EventModel] = []
    var latestEvents: [EventModel] = []
    var teams: [TeamModel] = []
    var bindResultToVC: (()->()) = {}
    var noData: (()->()) = {}
    var helper : NetworkManager?
    init() {
        self.helper = NetworkManager()
        //init for core data
    }
    func GetEvents()  {
        helper?.fetchData(url: url.UrlUpComingEvents(sport: sport!, leagueId: league.league_key, range: .nextYear), model: EventModelApiResponse.self, completion: { response, error in
            if let response = response {
                self.upcomingEvents = response.result
                DispatchQueue.main.async {
                    self.bindResultToVC()
                }

            } else {
                // display photo if ni data come from all section 
                print(error?.localizedDescription)
            }
        })
        
    }
    func GetLatestResults()  {
        helper?.fetchData(url: url.UrlUpComingEvents(sport: sport!, leagueId: league.league_key, range: .prevYear), model: EventModelApiResponse.self, completion: { response, error in
            if let response = response {
                self.latestEvents = response.result
                self.GetTeams()
                DispatchQueue.main.async {
                    self.bindResultToVC()
                }
            } else {
                print(error?.localizedDescription)
            }
        })
        
    }
    func GetTeams()  {
        teams = url.GetTeams(latestEvents: latestEvents)

    }
    
    
}

