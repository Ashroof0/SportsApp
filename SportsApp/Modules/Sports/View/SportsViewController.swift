//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 13/08/2024.
//

import UIKit
import Reachability
class SportsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var arrSports = SportViewModel().sports
    let reachability = try! Reachability()
    
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability.whenUnreachable = { _ in
            self.displayAlert()
            print("OFFLINE")
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

        MyCollectionView.dataSource = self
        MyCollectionView.delegate = self
        let cell = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        MyCollectionView.register(cell, forCellWithReuseIdentifier: "MyCollectionViewCell")
    }
    func displayAlert(){
        let alert : UIAlertController = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        let sport = arrSports[indexPath.row]
        cell.SportName.text = sport.title
        cell.MyImage.image = sport.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16) / 2
        return CGSize(width: width, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (reachability.connection == .unavailable){
            displayAlert()
        } else {
            var sport : SportType = .football
            switch indexPath.row {
            case 0 : sport = .football
            case 1 : sport = .basketball
            case 2 : sport = .cricket
            case 3 : sport = .tennis
            default :
                break
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let leagueVc = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
            leagueVc.viewModel.sport = sport
            leagueVc.viewModel.checkFav = false
            self.navigationController?.pushViewController(leagueVc, animated: true)
        }
      
    }
    
}
