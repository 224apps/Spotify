//
//  FeaturedPlaylistsCollectionViewCell.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/26/21.
//

import UIKit
import SDWebImage

class FeaturedPlaylistsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistsCollectionViewCell"

    private let playistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let playlistNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let creatorNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height-44,
            width: contentView.width-6,
            height: 30)
        
        playlistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height-60,
            width: contentView.width-6,
            height: 30)
        
        let imageSize = contentView.height - 70
        
        playistCoverImageView.frame = CGRect(
            x: (contentView.width - imageSize)/2,
            y: 3,
            width: imageSize,
            height: imageSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playistCoverImageView.image = nil
    }
    
    
    
    func configure(with viewModel: FeaturedPlaylistsCellViewModel){
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
