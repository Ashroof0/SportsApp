//
//  TeamsViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 13/08/2024.
//

import UIKit

class TeamsViewController: UIViewController {
    var team : Team!

    @IBOutlet weak var btnLinkedin: UIButton!
    @IBOutlet weak var btnInstgram: UIButton!
    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var btnFace: UIButton!
    @IBOutlet weak var imgTeamLogo: UIImageView!
    @IBOutlet weak var imgStadiumPhoto: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
                collectionView.register(UINib(nibName: "TeamCollecionCell", bundle: nil), forCellWithReuseIdentifier: "TeamCollecionCell")

        


    }
    // Actions:
    
    @IBAction func btnFace(_ sender: Any) {
        if(team!.website.isEmpty){
            displayAlert()
        }else{
            UIApplication.shared.open(URL(string: "https://"+(team!.website))!)
        }
    }
    @IBAction func btnLinkedin(_ sender: Any) {
        if(team!.website.isEmpty){
            displayAlert()
        }else{
            let websiteURL = URL(string: "website://"+(team!.website))!
            if UIApplication.shared.canOpenURL(websiteURL){
                UIApplication.shared.open(websiteURL)
            }else{
                UIApplication.shared.open(URL(string: "https://"+(team!.youtube))!)
            }
        }
        
        
    }
    @IBAction func btnInstgram(_ sender: Any) {
    }
    
    @IBAction func btnYoutube(_ sender: Any) {
        if(team!.youtube.isEmpty){
            displayAlert()
        }else{
            let youtubeURL = URL(string: "youtube://"+(team!.youtube))!
            if UIApplication.shared.canOpenURL(youtubeURL){
                UIApplication.shared.open(youtubeURL)
            }else{
                UIApplication.shared.open(URL(string: "https://"+(team!.youtube))!)
            }
        }
    }
    
}
extension TeamsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollecionCell", for: indexPath) as! TeamCollecionCell
        cell.labelSectionTitle.text = "My name"
        cell.labelBody.text = "bodrgjhdjsfhe rghreiugh riguh irhg rgh h ihf y"
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 15
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 40, height: collectionView.bounds.height / 5)
    }
    
    
}
