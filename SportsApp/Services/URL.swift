//
//  URL.swift
//  SportsApp
//
//  Created by Enas Mohamed on 18/08/2024.
//

import Foundation
struct url {
    static let baseUrl = "https://apiv2.allsportsapi.com"
    static let leagues = "/?met=Leagues"
    static let leagueDetails = "/?met=Fixtures&leagueId="
    static let teamDetails = "/?&met=Teams&teamId="
    static let apiKey = "&APIkey=0bc68f46726057023e1e02eb28928e583985eb955391773f06338d53ea5c234b"
    //https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=[team_key]&APIkey=[YourKey]

    static func UrlTeamsDetails (sport: SportType, TeamID: Int) -> URL? {
        print("HELLO")
        return URL(string: baseUrl + sport.rawValue + teamDetails + "\(TeamID)" + apiKey)
    }
    
    static func UrlLeagues (sport : SportType) -> URL? {
        return URL(string: baseUrl + sport.rawValue + leagues + apiKey)
    }
    
    static func UrlUpComingEvents(sport : SportType , leagueId : Int , range: DateRange) -> URL? {
        return URL(string: baseUrl + sport.rawValue + leagueDetails + "\(leagueId)" + range.get + apiKey)
    }
    static func GetTeams(latestEvents: [EventModel]) -> [TeamModel] {
        var arrofTeams : [TeamModel] = []
        var IdSet : Set<Int> = []
        for event in latestEvents {
            if !IdSet.contains(event.homeTeamKey){
                let team = TeamModel(teamKey: event.homeTeamKey, teamName: event.eventHomeTeam ?? "", teamLogo: event.homeTeamLogo, players: nil, coaches: nil)
                arrofTeams.append(team)
                IdSet.insert(event.homeTeamKey)
            }
            if !IdSet.contains(event.homeTeamKey){
                let team = TeamModel(teamKey: event.awayTeamKey, teamName: event.eventAwayTeam ?? "", teamLogo: event.awayTeamLogo, players: nil, coaches: nil)
                arrofTeams.append(team)
                IdSet.insert(event.awayTeamKey)
            }
        }
        
        return arrofTeams
    }
   
}
public enum DateRange: String {
    case prevYear
    case nextYear
    
    var get: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        
        switch self {
        case .prevYear:
            let pastYear = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!
            let prevDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            return "&from=\(formatter.string(from: pastYear))&to=\(formatter.string(from: prevDay))"
        case .nextYear:
            let comingYear = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
            return "&from=\(formatter.string(from: currentDate))&to=\(formatter.string(from: comingYear))"
        }
    }
}
