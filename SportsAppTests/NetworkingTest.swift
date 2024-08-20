//
//  NetworkTesting.swift
//  SportsApp
//
//  Created by Enas Mohamed on 19/08/2024.
//

import XCTest
@testable import SportsApp
import SwiftUI

final class NetworkTesting: XCTestCase {

    var helper : NetworkManager!
    var viewModel = LeagueDetailsViewModel()
    var leagueModel = LeagueViewModel()
    override func setUpWithError() throws {
        helper = NetworkManager()
    }

    override func tearDownWithError() throws {
        helper = nil
    }

    func testNetworkResponseSuccess() throws {
        let sport = SportType.football
        let allLeaguesURL = url.UrlLeagues(sport: sport)
        
        let expectedObject = XCTestExpectation(description: "waiting for API response")
        helper?.fetchData(url: allLeaguesURL, model: FootballLeaguesBaseResponse.self, completion: { result, error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            if let result = result {
                XCTAssertEqual(result.success, 1)
                expectedObject.fulfill()
            } else {
                XCTFail("No result returned")
            }
        })
        wait(for: [expectedObject],timeout: 10)
    }
    
    func testNetworkWrongModelFailure() throws {
        let sport = SportType.football
        let leagueID = 332
        let nextYearDateRange = DateRange.nextYear
        let prevYearDateRange = DateRange.prevYear
        let wrongModel = TeamModel.self
        let leagueDetailsURL = url.UrlUpComingEvents(sport: sport, leagueId: leagueID, range: nextYearDateRange)
        let _ = url.UrlUpComingEvents(sport: sport, leagueId: leagueID, range: prevYearDateRange)
        
        let expectedObject = XCTestExpectation(description: "waiting for API response")
        helper?.fetchData(url: leagueDetailsURL, model: wrongModel, completion: { result, error in
            XCTAssertNotNil(error)
            XCTAssertNil(result)
            expectedObject.fulfill()
        })
        wait(for: [expectedObject],timeout: 10)
    }

    func testNetworkNoURLFailure() throws {
        let _ = url.UrlTeamsDetails(sport: .football, TeamID: 332)
        
        let expectedObject = XCTestExpectation(description: "waiting for API response")
        helper?.fetchData(url: nil, model: TeamModel.self, completion: { result, error in
            if let error = error {
                XCTAssertEqual((error as NSError).domain , "URL error")
                expectedObject.fulfill()
            }
        })
        wait(for: [expectedObject],timeout: 10)
    }
 
  

    
}




