//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Enas Mohamed on 17/08/2024.
//

import UIKit
import CoreData

class LeagueDetailsViewController: UIViewController {
    
    var viewModel = LeagueDetailsViewModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).context
    
    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var LeagueDetails: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
    }
    
    
    private func setupUI() {
        configureNavigation()
        configureCollectioView()
        
        viewModel.bindResultToVC = {
            self.LeagueDetails.reloadData()
        }
        viewModel.notFoundData = {
            self.notFoundImage.isHidden = false
            self.LeagueDetails.isHidden = true
        }
        viewModel.GetEvents()
        viewModel.GetLatestResults()
        
        let compositional = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            switch sectionIndex {
            case 0 :
                return self.drawUpComingSection()
            case 1 :
                return self.drawLatestSection()
            default:
                return self.drawTeamsSection()
            }
        }
        
        LeagueDetails.setCollectionViewLayout(compositional, animated: true)
    }
    
    private func configureNavigation() {
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: isFavorite() ? "star.fill" : "star"),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func favoriteButtonTapped() {
        guard let league = self.viewModel.league else { return }
        
        if isFavorite() {
            removeFavoriteLeague(leagueKey: league.league_key)
        } else {
            addFavoriteLeague(league: league)
        }
        
        configureNavigation()
        
        print("Favorite button tapped. Current favorites: \(fetchFavoriteLeagues())")
    }
    
    private func isFavorite() -> Bool {
        guard let league = self.viewModel.league else { return false }
        let fetchRequest: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "league_key == %d", league.league_key)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Failed to fetch favorite leagues: \(error)")
            return false
        }
    }
    
    private func addFavoriteLeague(league: Leagues) {
        let favoriteLeague = FavoriteLeague(context: context)
        favoriteLeague.league_key = Int64(Int(league.league_key))
        favoriteLeague.league_name = league.league_name
        favoriteLeague.league_logo = league.league_logo
        favoriteLeague.sportType = self.viewModel.sport?.rawValue

        do {
            try context.save()
        } catch {
            print("Failed to save favorite league: \(error)")
        }
    }
    
    private func removeFavoriteLeague(leagueKey: Int) {
        let fetchRequest: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "league_key == %d", leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                context.delete(result)
            }
            try context.save()
        } catch {
            print("Failed to remove favorite league: \(error)")
        }
    }
    
    private func fetchFavoriteLeagues() -> [FavoriteLeague] {
        let fetchRequest: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorite leagues: \(error)")
            return []
        }
    }
    
    private func configureCollectioView() {
        LeagueDetails.delegate = self
        LeagueDetails.dataSource = self
        let nib = UINib(nibName: "EventsCollectionViewCell", bundle: nil)
        LeagueDetails.register(nib, forCellWithReuseIdentifier: "EventsCollectionViewCell")
        let nib2 = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        LeagueDetails.register(nib2, forCellWithReuseIdentifier: "TeamsCollectionViewCell")
    }
    
    
    func drawUpComingSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
    }
    
    func drawLatestSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(UIScreen.main.bounds.height/5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
        
    }
    
    func drawTeamsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension:  .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }
}

extension LeagueDetailsViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.upcomingEvents.count
        case 1:
            return viewModel.latestEvents.count
        case 2:
            return viewModel.teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionViewCell", for: indexPath) as! EventsCollectionViewCell
            cell.configure(eventModel: viewModel.upcomingEvents[indexPath.row])
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionViewCell", for: indexPath) as! EventsCollectionViewCell
            cell.configure(eventModel: viewModel.latestEvents[indexPath.row])
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCollectionViewCell", for: indexPath) as! TeamsCollectionViewCell
            cell.CellSetUp(team: viewModel.teams[indexPath.row])
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
          
            self.performSegue(withIdentifier: "TeamDetailsSegue", sender: (viewModel.sport, viewModel.teams[indexPath.item].teamKey))
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "TeamDetailsSegue" {
                    if let nextViewController = segue.destination as? TeamDetailsVC {
                        let (sport, teamKey) = sender as! (SportType, Int)
                        nextViewController.viewModel.sport = sport
                        nextViewController.viewModel.teamID = teamKey
                    }
                }
            }
    
}
