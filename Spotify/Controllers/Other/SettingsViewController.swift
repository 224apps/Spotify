//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    struct  Constants {
        static let CellID = "CellID"
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellID )
        return tableView
    }()
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SettingsView"
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    private func configureModels(){
        sections.append(Section(title: "Profile",
                                options: [Option(title: "View Your Profile",
                                                 handler: { [weak self] in
                                                    DispatchQueue.main.async {
                                                        self?.viewProfile()
                                                    }
                                                 })]))
        sections.append(Section(title: "Account",
                                options: [Option(title: "Sign Out",
                                                 handler: { [weak self] in
                                                    DispatchQueue.main.async {
                                                        self?.signOutTapped()
                                                    }
                                                 })]))
    }
    
    
    private func  viewProfile(){
        let vc = ProfileViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    private func  signOutTapped(){
        
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellID, for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //handler for cell
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
