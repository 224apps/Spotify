//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import UIKit
import SDWebImage



class ProfileViewController: UIViewController {
    
    struct  Constants {
        static let CellID = "CellID"
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellID )
        return tableView
    }()
    
    private var models = [String]()
    
    
    //MAKR: -Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor  = .systemBackground
        fetchProfile()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func  fetchProfile() {
        APICaller.shared.getCurrentUserProfile {  [weak self] (result) in
            switch result {
                case .success(let model):
                    DispatchQueue.main.async {
                        self?.updateUI(with: model)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.failedToGetProfile()
                    }
                    
            }
        }
    }
    
    private func updateUI(with model: UserProfile ){
        tableView.isHidden = false
        //Configure tableViewModels
        models.append("Full Name: \(model.display_name)")
        models.append("Email: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
        
    }
    
    private func createTableHeader(with string: String?){
        guard let urlString = string, let url = URL(string:urlString) else { return }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        tableView.tableHeaderView = headerView
    }
    
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        label.text = "Failed to load the profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
}


//MARK: - UITableViewDelegate & UITableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = models[indexPath.row]
        return cell
    }
    
    
}
