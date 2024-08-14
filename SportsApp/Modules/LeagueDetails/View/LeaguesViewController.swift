//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 15/08/2024.
//

import UIKit

class LeaguesViewController: UIViewController {
    private var viewModel = LeagueViewModel()
    var sport : SportType = .football
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchLeagues()
    
    }
    func fetchLeagues(){
        // show indector 
        viewModel.onLeaguesFetched = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                // hide the indector
            }
            
        }
        viewModel.getLeagues(sport: sport)
    }
}
extension LeaguesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfLeagues()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        if let league = viewModel.league(at: indexPath.row){
            cell.leagueName.text = league.league_name
        }
        return cell
        
        
    }
    
    
}
