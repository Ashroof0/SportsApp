//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Enas Mohamed on 15/08/2024.
//

import UIKit
import SDWebImage
class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        teamImage.layer.cornerRadius = teamImage.frame.width / 2
        
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)

        // Initialization code
    }
    @IBAction func PlayButtonAction(_ sender: UIButton) {
        DispatchQueue.main.async{
            self.openYouTube()
        }
    }
    func openYouTube() {
            var str = leagueName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            str = str.replacingOccurrences(of: " ", with: "")
            print("\(str)")
            UIApplication.shared.open(URL(string: ("https://www.youtube.com/@\(str)"))!, options: [:], completionHandler: nil)
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func cellSetup(league: Leagues){
        //self.teamImage.sd_setImage(with: URL(string: league.league_logo!), placeholderImage: UIImage(named: ""))
        self.leagueName.text = league.league_name
        
        //self.teamImage.image = UIImage(named: "")
    }

}
