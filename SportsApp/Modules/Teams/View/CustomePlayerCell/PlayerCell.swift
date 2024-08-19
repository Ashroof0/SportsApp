//
//  PlayerCell.swift
//  SportsApp
//
//  Created by Enas Mohamed on 19/08/2024.
//

import UIKit
import SDWebImage

class PlayerCell: UITableViewCell {
    @IBOutlet weak var playerImgView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerNumberLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCellUI() {
        playerImgView.layer.cornerRadius = 16
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.systemBrown.cgColor
        view.layer.borderWidth = 0.3
    }
    
    func setupCell(player: Player) {
        let placeHoler = UIImage(named: "soccerPlayer")
        playerImgView.sd_setImage(with: URL(string: player.playerImage ?? ""), placeholderImage: placeHoler)
        playerNameLabel.text = player.playerName
        if player.playerNumber == ""{
            playerNumberLabel.text = "0"
        }else {
            playerNumberLabel.text = player.playerNumber
        }
    }

}
