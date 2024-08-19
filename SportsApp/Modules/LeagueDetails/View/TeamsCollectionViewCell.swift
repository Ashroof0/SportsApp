//
//  TeamsCollectionViewCell.swift
//  SportsApp
//
//  Created by Enas Mohamed on 18/08/2024.
//

import UIKit
import SDWebImage
class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        teamImageView.layer.cornerRadius = teamImageView.layer.bounds.width / 2
    }
    func CellSetUp(team : TeamModel)  {
        teamLbl.text = team.teamName
        let placeholderImage = UIImage(systemName: "heart.fill")
        teamImageView.sd_setImage(with: URL(string: team.teamLogo ?? ""),placeholderImage: placeholderImage, options: .highPriority, completed: nil )
    }
}
