//
//  SportsViewModel.swift
//  SportsApp
//
//  Created by Enas Mohamed on 13/08/2024.
//

import Foundation
import UIKit
class SportViewModel{
    
    var sports : [Sport] = []
    init(){sports.append(Sport(image: UIImage(named: "football"), title: "Football"))
        sports.append(Sport(image: UIImage(named: "basketball"), title: "Basketball"))
        sports.append(Sport(image: UIImage(named: "cricket"), title: "Cricket"))
        sports.append(Sport(image: UIImage(named: "tennis"), title: "TENNIS"))
    }
    
    
}
