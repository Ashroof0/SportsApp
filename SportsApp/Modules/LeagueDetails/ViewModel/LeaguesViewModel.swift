//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Enas Mohamed on 15/08/2024.
//

import Foundation
class LeagueViewModel {
    private var leagues: [Leagues] = []
    var onLeaguesFetched: (() -> Void)?
    var onFetchFailed: ((Error) -> Void)?
    let manager = NetworkManager.manager
    
    func getLeagues(sport : SportType) {
        manager.getFootballLeagues(sport: sport){ [weak self] league in
            if let league = league.result {
                self?.leagues = league
            }
            self?.onLeaguesFetched!()
        } faildHandler: { [weak self] error in
            print(error.localizedDescription)
            self?.onFetchFailed?(error)
        }
        
    }
    func numberOfLeagues() -> Int {
        return leagues.count
    }
    func league(at index: Int) -> Leagues? {
            guard index < leagues.count else { return nil }
            return leagues[index]
        }
}

