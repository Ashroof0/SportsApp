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
  
    // func to get leagues details
        func fetchData<T: Codable>(url: URL?, model: T.Type, completion: @escaping (T?,Error?)->Void) {
            guard let url = url else {
                let error = NSError(domain: "URL error", code: 0, userInfo: [NSLocalizedDescriptionKey : "URL is nil"])
                completion(nil,error)
                return
            }
            AF.request(url).validate().responseDecodable(of: model.self) { response in
                switch response.result{
                case .success(let decodedResult):
                    completion(decodedResult,nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil,error)
                }
            }
        }
    

}
enum SportType: String {
    case football = "/football"
    case basketball = "/basketball"
    case cricket = "/cricket"
    case tennis = "/tennis"
    
    init?(from rawValue: String) {
        switch rawValue {
        case "/football":
            self = .football
        case "/basketball":
            self = .basketball
        case "/cricket":
            self = .cricket
        case "/tennis":
            self = .tennis
        default:
            return nil
        }
    }
    
    var stringValue: String {
        return self.rawValue
    }
}
