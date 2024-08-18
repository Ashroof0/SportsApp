//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Enas Mohamed on 15/08/2024.
//

import Foundation
import Alamofire
class LeagueViewModel {
    var chechFav : Bool = true
    private var leagues: [Leagues] = []
    var onLeaguesFetched: (() -> Void)?
    var onFetchFailed: ((Error) -> Void)?
    let manager = NetworkManager.manager
    var sport : SportType?
    func getLeagues() {
        manager.fetchData(url: url.UrlLeagues(sport: sport!), model: FootballLeaguesBaseResponse.self) { respons, error in
            if let respons = respons {
                self.leagues = respons.result
                self.onLeaguesFetched!()
            }else {
                print(error!)
            }
        }
    }
    func checkFav()->Bool{
        return chechFav
    }
    func numberOfLeagues() -> Int {
        return leagues.count
    }
    func league(at index: Int) -> Leagues? {
            guard index < leagues.count else { return nil }
            return leagues[index]
        }
}

