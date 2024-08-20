//
//  ViewModelTesting.swift
//  SportsAppTests
//
//  Created by Enas Mohamed on 20/08/2024.
//

import XCTest
@testable import SportsApp
import CoreData
class ViewModelTesting: XCTestCase {
    
     var viewModel = LeagueDetailsViewModel()
    var ViewModelDetails = LeagueDetailsViewController()
    var viewModelPlayer = TeamDetailsViewModel()
    
    func testLeagueDetailsViewModel() throws {
        let expectedResult = XCTestExpectation(description: "waiting for View Model")
        let fetchRequest = viewModel.GetTeams()
        expectedResult.fulfill()
        wait(for: [expectedResult],timeout: 10)
    }
    func testAddToCoreData () throws {
        
        let league = Leagues(league_key: 1, league_name: "test1", country_key: 1, country_name: "test1", league_logo: "test1", country_logo: "test1", league_year: "\(1)")
        ViewModelDetails.addFavoriteLeague(league: league)
        XCTAssertEqual(league.league_name, "test1" )
    }
    
    func testGetPlayer() throws{
        XCTAssertEqual(viewModelPlayer.players.count, 0)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
