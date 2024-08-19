//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 15/08/2024.
//

import UIKit
import SDWebImage
import CoreData
import Reachability
class LeaguesViewController: UIViewController {
    var viewModel = LeagueViewModel()
    let reachability = try! Reachability()
    @IBOutlet weak var tableView: UITableView!
    var leagueId: Int?
    var isFavourite: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        reachability.whenUnreachable = { _ in
            self.displayAlert()
            print("OFFLINE")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
      
    }
    func displayAlert(){
        let alert : UIAlertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        viewModel.getLeagues()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "GoToDetails" {
              if let destinationVC = segue.destination as? LeagueDetailsViewController {
                  destinationVC.viewModel.league = viewModel.league(at: sender as! Int)
                  destinationVC.viewModel.sport = viewModel.sport
              }
          }
      }
}

extension LeaguesViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfLeagues()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (reachability.connection == .unavailable){
            displayAlert()
        }else{
            self.performSegue(withIdentifier: "GoToDetails", sender: indexPath.row)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        if let league = viewModel.league(at: indexPath.row){
            if league.league_logo != nil {
                cell.teamImage.sd_setImage(with: URL(string: league.league_logo!))
                                           }else {
                                               cell.teamImage.image = UIImage(systemName: "person.fill")
                                                                              }
            cell.leagueName.text = league.league_name
        }
        return cell
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }

}
