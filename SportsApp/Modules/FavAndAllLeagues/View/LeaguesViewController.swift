//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 15/08/2024.
//

import UIKit
import SDWebImage
class LeaguesViewController: UIViewController {
    var viewModel = LeagueViewModel()
    var sport : SportType = .football
    @IBOutlet weak var tableView: UITableView!
    var leagueId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if viewModel.chechFav{
            print("Came from Fav")
            //coredata
        } else {
            fetchLeagues()
        }
            
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "GoToDetails" {
              if let destinationVC = segue.destination as? LeagueDetailsViewController {
                  destinationVC.leagueId = leagueId

              }
          }
      }
}
extension LeaguesViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfLeagues()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let league = viewModel.league(at: indexPath.row){
            self.leagueId = league.league_league_key
            performSegue(withIdentifier: "GoToDetails", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        if let league = viewModel.league(at: indexPath.row){
        //    cell.leagueName.text = league.league_name
            if league.league_logo != nil {
                cell.teamImage.sd_setImage(with: URL(string: league.league_logo!))
                                           }else {
                                               cell.teamImage.image = UIImage(systemName: "person.fill")
                                                                              }
            cell.leagueName.text = league.league_name
            //cell.cellSetup(league: league)
        }
        return cell
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }

}
