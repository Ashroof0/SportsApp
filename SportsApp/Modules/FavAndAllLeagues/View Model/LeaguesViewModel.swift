//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Enas Mohamed on 15/08/2024.
//

import Foundation
import Alamofire
import CoreData
import UIKit

class LeagueViewModel {
    var checkFav: Bool = true
    private var leagues: [Leagues] = []
    var onLeaguesFetched: (() -> Void)?
    var onFetchFailed: ((Error) -> Void)?
    let manager = NetworkManager.manager
    private let context = (UIApplication.shared.delegate as! AppDelegate).context

    var sport: SportType?
    
    func getLeagues() {
        if checkFav {
            let favoriteLeagues = fetchFavoriteLeagues()
            if let firstFavoriteLeague = favoriteLeagues.first {
                if let sportType = SportType(from: firstFavoriteLeague.sportType ?? "") {
                    self.sport = sportType
                } else {
                    print("Invalid SportType string")
                }
            }
            leagues = favoriteLeagues.map { favoriteLeague in
                Leagues(
                    league_key: Int(favoriteLeague.league_key),
                    league_name: favoriteLeague.league_name ?? "",
                    country_key: nil,
                    country_name: nil,
                    league_logo: nil,
                    country_logo: favoriteLeague.league_logo,
                    league_year: nil
                )
            }
            onLeaguesFetched?()
        } else {
            guard let sport = sport else {
                print("Sport is nil. Cannot fetch leagues.")
                return
            }
            manager.fetchData(url: url.UrlLeagues(sport: sport), model: FootballLeaguesBaseResponse.self) { response, error in
                if let response = response {
                    self.leagues = response.result
                    self.onLeaguesFetched?()
                } else if let error = error {
                    self.onFetchFailed?(error)
                }
            }
        }
    }
    
    
    func numberOfLeagues() -> Int {
        if checkFav {
            return fetchFavoriteLeagues().count
        } else {
            return leagues.count
        }
    }
    
    func league(at index: Int) -> Leagues? {
        if checkFav {
            let favoriteLeagues = fetchFavoriteLeagues()
            guard index < favoriteLeagues.count else { return nil }
            let favoriteLeague = favoriteLeagues[index]
            return Leagues(
                league_key: Int(favoriteLeague.league_key),
                league_name: favoriteLeague.league_name ?? "",
                country_key: nil,
                country_name: nil,
                league_logo: favoriteLeague.league_logo,
                country_logo: nil,
                league_year: nil
            )
        } else {
            guard index < leagues.count else { return nil }
            return leagues[index]
        }
    }
    
    private func fetchFavoriteLeagues() -> [FavoriteLeague] {
        let fetchRequest: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorite leagues: \(error)")
            return []
        }
    }
}
