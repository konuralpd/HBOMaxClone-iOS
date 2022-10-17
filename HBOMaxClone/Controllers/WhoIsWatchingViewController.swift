//
//  WhoIsWatchingViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 17.10.2022.
//

import UIKit

class WhoIsWatchingViewController: UIViewController {

    private let profile1Button: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "profile1") as UIImage?
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let profile2Button: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "profile2") as UIImage?
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let profile3Button: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "profile3") as UIImage?
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let profile4Button: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "profile4") as UIImage?
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let whoIsWatchingLabel: UILabel = {
       let label = UILabel()
        label.text = "Kim İzliyor?"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "hbomaxLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(patternImage: UIImage(named: "purpleGradient")!)

        view.addSubview(logoImageView)
        view.addSubview(whoIsWatchingLabel)
        view.addSubview(profile1Button)
        view.addSubview(profile2Button)
        view.addSubview(profile3Button)
        view.addSubview(profile4Button)
        
        makeConstraints()
      
    }
    
    @objc func didTapProfile() {
        
        navigationController?.pushViewController(TabBarViewController(), animated: true)
    }
    
    private func  makeConstraints() {
        let logoImageViewConstraints = [
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 60)
        ]

        let whoIsWatchingLabelConstraints = [
            whoIsWatchingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whoIsWatchingLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
        ]
        
        let profile1ButtonConstraints = [
            profile1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profile1Button.topAnchor.constraint(equalTo: whoIsWatchingLabel.bottomAnchor, constant: 20),
            profile1Button.widthAnchor.constraint(equalToConstant: 100),
            profile1Button.heightAnchor.constraint(equalToConstant: 130)
        ]
        
        let profile2ButtonConstraints = [
            profile2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profile2Button.topAnchor.constraint(equalTo: profile1Button.bottomAnchor, constant: 10),
            profile2Button.widthAnchor.constraint(equalToConstant: 100),
            profile2Button.heightAnchor.constraint(equalToConstant: 130)
        ]

        let profile3ButtonConstraints = [
            profile3Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profile3Button.topAnchor.constraint(equalTo: profile2Button.bottomAnchor, constant: 10),
            profile3Button.widthAnchor.constraint(equalToConstant: 100),
            profile3Button.heightAnchor.constraint(equalToConstant: 130)
        ]
        
        let profile4ButtonConstraints = [
            profile4Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profile4Button.topAnchor.constraint(equalTo: profile3Button.bottomAnchor, constant: 10),
            profile4Button.widthAnchor.constraint(equalToConstant: 100),
            profile4Button.heightAnchor.constraint(equalToConstant: 130)
        ]

        NSLayoutConstraint.activate(logoImageViewConstraints)
        NSLayoutConstraint.activate(whoIsWatchingLabelConstraints)
        NSLayoutConstraint.activate(profile1ButtonConstraints)
        NSLayoutConstraint.activate(profile2ButtonConstraints)
        NSLayoutConstraint.activate(profile3ButtonConstraints)
        NSLayoutConstraint.activate(profile4ButtonConstraints)
    }

}
