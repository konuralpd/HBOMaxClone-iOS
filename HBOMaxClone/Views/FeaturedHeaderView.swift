//
//  FeaturedHeaderView.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit

class FeaturedHeaderView: UIView {
    
    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("Oynat", for: .normal)
        let image = UIImage(named: "purpleGradient2") as UIImage?
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let trailerButton: UIButton = {
       let button = UIButton()
        button.setTitle("Fragman", for: .normal)
        button.layer.borderColor = UIColor(named: "softPurple")?.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let downloadButton: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "downloadFeatured")?.withRenderingMode(.alwaysTemplate) as UIImage?
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.borderColor = UIColor(named: "softPurple")?.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        return button
    }()
    
    
    private let featuredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "houseofdragons")
        return imageView
    }()
    
    private let topMenuButton: UIButton = {
        let button = UIButton()
         let image = UIImage(named: "menu")
         button.setImage(image, for: .normal)
         button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "hbomaxLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "jokerProfileImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let featuredMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 36.0)!
        label.text = "House Of Dragons"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private func addGradientToFeatured() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(featuredImageView)
        addGradientToFeatured()
        addSubview(playButton)
        addSubview(trailerButton)
        addSubview(downloadButton)
        addSubview(topMenuButton)
        addSubview(logoImageView)
        addSubview(profileImageView)
        addSubview(featuredMovieLabel)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        featuredImageView.frame = bounds
    }
    
    
    
    private func  makeConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            playButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        let trailerButtonConstraints = [
            trailerButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            trailerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            trailerButton.widthAnchor.constraint(equalToConstant: 120),
            trailerButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.leadingAnchor.constraint(equalTo: trailerButton.trailingAnchor, constant: 20),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            downloadButton.widthAnchor.constraint(equalToConstant: 80),
            downloadButton.heightAnchor.constraint(equalToConstant: 36)
        ]
        
        let topMenuButtonConstraints = [
            topMenuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topMenuButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topMenuButton.widthAnchor.constraint(equalToConstant: 32),
            topMenuButton.heightAnchor.constraint(equalToConstant: 32)
        ]
        
        let logoImageViewConstraints = [
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let profileImageViewConstraints = [
            profileImageView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),

        ]
        
        let featuredMovieLabel = [
            featuredMovieLabel.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -12),
            featuredMovieLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)

        ]
     
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(trailerButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
        NSLayoutConstraint.activate(topMenuButtonConstraints)
        NSLayoutConstraint.activate(logoImageViewConstraints)
        NSLayoutConstraint.activate(profileImageViewConstraints)
        NSLayoutConstraint.activate(featuredMovieLabel)
    }
    
   
    

}
