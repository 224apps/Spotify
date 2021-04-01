//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/28/21.
//

import UIKit
import SDWebImage

class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let imageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image =  UIImage(systemName: "photo")
        return imageView
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(ownerLabel)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    @objc func didTapPlayAll(){
        //play
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = height/1.8
        imageView.frame = CGRect(x: (width - imageSize)/2, y: 20, width: imageSize, height: imageSize)
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width - 20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width - 20, height: 44)
        ownerLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom , width: width - 20, height: 44)
        playAllButton.frame = CGRect(x: width-50, y: ownerLabel.bottom - 50 , width: 50, height: 50)
        
        

    }
    
    func configure(with viewModel: PlaylistHeaderViewViewModel ) {
        nameLabel.text = viewModel.name
        ownerLabel.text = viewModel.ownerName
        descriptionLabel.text = viewModel.description
        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
