//
//  NetworkManager.swift
//  SportsApp
//
//  Created by Enas Mohamed on 13/08/2024.
//

import Foundation
import Alamofire
//create function to get data from API using Alamofire
class NetworkManager{
  
    static let manager = NetworkManager()
    func getFootballLeagues(sport : SportType, successHandler: @escaping (FootballLeaguesBaseResponse) -> Void, faildHandler: @escaping (Error) -> Void) {
        let url = "\(Config.footballBaseURL)\(sport.rawValue)?met=Leagues&APIkey=\(Config.apiKey)"

            AF.request(url, method: .get).responseDecodable(of: FootballLeaguesBaseResponse.self) { response in
                switch response.result {
                case .success(let leaguesResponse):
                    successHandler(leaguesResponse)
                case .failure(let error):
                    faildHandler(error)
                }
            }

    }
    // func to get leagues details 

}
enum SportType : String {
case football = "football"
    case basketball = "basketball"
    case cricket = "cricket"
    case tennis = "tennis"
}
