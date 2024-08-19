//
//  TeamDetailsVC.swift
//  SportsApp
//
//  Created by Enas Mohamed on 19/08/2024.
//

import UIKit
import SDWebImage
class TeamDetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var imgViewBG: UIImageView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var playersTableView: UITableView!
    let indicator = UIActivityIndicatorView(style: .large)
    var viewModel = TeamDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    private func setupUI(){
        addGradientToBGImage()
        configTable()
        setupIndicator()
        checkSport()
        viewModel.getTeamDetails()
    }
    private func setupViewModel(){
        viewModel.bindResultToViewController = {
            let placeholderImage = UIImage(named: "basketball")
            self.logoImgView.sd_setImage(with: URL(string: self.viewModel.team[0].teamLogo ?? "") , placeholderImage: placeholderImage)
            self.teamNameLabel.text = self.viewModel.team[0].teamName
            self.playersTableView.reloadData()
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
        viewModel.noResultFound = {
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
            self.noDataImage.isHidden = false
            self.playersTableView.isHidden = true
        }
    }
    private func configTable(){
        playersTableView.delegate = self
        playersTableView.dataSource = self
        let nib = UINib(nibName: "PlayerCell", bundle: nil)
        playersTableView.register(nib, forCellReuseIdentifier: "PlayerCell")
    }
    
    private func addGradientToBGImage(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imgViewBG.bounds
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.locations = [0.0, 0.2, 0.8, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        imgViewBG.layer.addSublayer(gradientLayer)
    }
    private func checkSport(){
        switch viewModel.getSportType() {
        case .football:
            imgViewBG.image = UIImage(named: "FStadium")
        case .basketball:
            imgViewBG.image = UIImage(named: "BStadium")
        case .cricket:
            imgViewBG.image = UIImage(named: "CStadium")
        case .tennis:
            imgViewBG.image = UIImage(named: "TStadium")
      
        }
        
    }
    private func setupIndicator(){
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    //MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPlayersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        cell.setupCell(player: viewModel.getPlayer(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
