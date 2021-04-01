//
//  RecommendedTracksCollectionViewCell.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/26/21.
//

import UIKit
import SDWebImage

class RecommendedTracksCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTracksCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let trackNamelabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let artistNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNamelabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: contentView.height/2,
            width: contentView.width - albumCoverImageView.right - 15,
            height: contentView.height/2)
        
        trackNamelabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: 0,
            width: contentView.width - albumCoverImageView.right - 15,
            height: contentView.height/2)
    
        albumCoverImageView.frame = CGRect( x: 5, y:2, width: contentView.height - 4, height: contentView.height - 4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNamelabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTracksCellViewModel){
        trackNamelabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
