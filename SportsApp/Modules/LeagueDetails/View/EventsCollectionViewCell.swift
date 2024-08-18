//
//  EventsCollectionViewCell.swift
//  SportsApp
//
//  Created by Enas Mohamed on 17/08/2024.
//

import UIKit
import SDWebImage
class EventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var TeamAwayImage: UIImageView!
    @IBOutlet weak var TeamHomeImage: UIImageView!
    
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var awayTeamlbl: UILabel!
    @IBOutlet weak var homeTeamLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        
    }
    func SetUpCell(eventModel : EventModel)  {
        
        homeTeamLbl.text = eventModel.eventHomeTeam
        awayTeamlbl.text = eventModel.eventAwayTeam
        dataLbl.text = eventModel.eventDate
        timeLbl.text = eventModel.eventTime
        let placeholderImage = UIImage(systemName: "heart.fill")
        TeamHomeImage.sd_setImage(with: URL(string: eventModel.homeTeamLogo!),placeholderImage: placeholderImage, options: .highPriority, completed: nil )
        TeamAwayImage.sd_setImage(with: URL(string: eventModel.awayTeamLogo!),placeholderImage: placeholderImage, options: .highPriority, completed: nil )
        if eventModel.eventFinalResult == "-" {
            resultLbl.text = ""
        } else{
            resultLbl.text = eventModel.eventFinalResult
        }
    }

}
