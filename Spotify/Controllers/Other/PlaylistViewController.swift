//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//


import UIKit

class PlaylistViewController: UIViewController {
    
    private let playlist: Playlist
    
    private var collectionView: UICollectionView =  UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            //let Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0))
            )
            item.contentInsets  = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
            
            //Group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(60)),
                subitem: item,
                count: 1)
            
            //Section
            let section  = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize:NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)) ,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
            ]
            return section
        }
    )
    
    
    private var viewModels = [RecommendedTracksCellViewModel]()
    
    //Initializers
    
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playlist.name
        view.backgroundColor  = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.backgroundColor  = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            RecommendedTracksCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendedTracksCollectionViewCell.identifier
        )
        
        collectionView.register(
            PlaylistHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
        
        APICaller.shared.getPlaylistDetails(for: playlist) { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let model):
                        self?.viewModels = model.tracks.items.compactMap{
                            RecommendedTracksCellViewModel(
                                name: $0.track.name,
                                artistName: $0.track.artists.first?.name ?? "-",
                                artworkURL: URL(string:  $0.track.album?.images.first?.url ?? ""))
                        }
                    case .failure(_): break
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    //MARK: - Helpers
    
}


extension PlaylistViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendedTracksCollectionViewCell.identifier,
            for: indexPath
        )  as? RecommendedTracksCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard  kind == UICollectionView.elementKindSectionHeader,
               let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier,
                for: indexPath) as? PlaylistHeaderCollectionReusableView else {return UICollectionReusableView()}
        
        let headerViewModel =  PlaylistHeaderViewViewModel(
            name: playlist.name,
            ownerName: playlist.owner.display_name,
            description: playlist.description,
            artworkURL: URL(string: playlist.images.first?.url ?? ""))
        header.configure(with:headerViewModel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //Play the Song
        
    }
    
}
