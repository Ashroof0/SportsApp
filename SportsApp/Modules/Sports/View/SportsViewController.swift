//
//  SportsViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 13/08/2024.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var arrSports = SportViewModel().sports
    

    @IBOutlet weak var MyCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MyCollectionView.dataSource = self
        MyCollectionView.delegate = self
        let cell = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        MyCollectionView.register(cell, forCellWithReuseIdentifier: "MyCollectionViewCell")
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        let sport = arrSports[indexPath.row]
        cell.SportName.text = sport.title
    //    cell.MyImage.image = sport.image
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.width * 0.499, height: self.view.frame.height * 0.20)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.1
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0.1
       }

}
