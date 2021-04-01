//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Abdoulaye Diallo on 3/23/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signinButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signinButton)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signinButton.frame = CGRect(x: 20,
                                    y: view.height-50-view.safeAreaInsets.bottom,
                                    width:view.width-40, height: 50)
    }
    
    @objc func didTapSignIn(){
        let vc = AuthViewController()
        vc.completionHandler  = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool ){
        guard success else {
            let alert = UIAlertController(title: "Oops",
                                          message: "Something went wromg when signing in",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainTabBarVC = TabBarViewController()
        mainTabBarVC.modalPresentationStyle = .fullScreen
        present(mainTabBarVC, animated: true)
        
        
    }
}
