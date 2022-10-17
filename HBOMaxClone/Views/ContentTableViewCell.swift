//
//  ContentTableViewCell.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit
import SDWebImage

class ContentTableViewCell: UITableViewCell {

   static let identifier = "ContentTableViewCell"
    
    private let contentPosterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: 120, height: 240)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentPosterImageView)
        addSubview(contentTitle)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        let  contentPosterImageViewConstraints = [
            contentPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            contentPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            contentPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            contentPosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let  contentTitleLabelConstraints = [
            contentTitle.leadingAnchor.constraint(equalTo: contentPosterImageView.trailingAnchor, constant: 20),
            contentTitle.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(contentPosterImageViewConstraints)
        NSLayoutConstraint.activate(contentTitleLabelConstraints)
    }
    
    public func configure(with model: ContentViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterUrl)") else { return
        }
     
        contentPosterImageView.sd_setImage(with: url)
        contentPosterImageView.layer.cornerRadius = 8
        contentPosterImageView.clipsToBounds = true
        contentTitle.text = model.titleName
        contentTitle.numberOfLines = 0
        contentTitle.lineBreakMode = .byWordWrapping

    }
}
