//
//  ContentCollectionViewCell.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit
import SDWebImage

class ContentCollectionViewCell: UICollectionViewCell {
    static let identifier = "ContentCollectionViewCell"
    var contents = [MovieResult]()
    public let contentImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let movieNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contentImageView)
        contentView.addSubview(movieNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentImageView.frame = contentView.bounds
    }
    
    
    
    public func configure(with model: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") 
        
        contentImageView.sd_setImage(with: url ?? URL(string: "https://play-lh.googleusercontent.com/1iyX7VdQ7MlM7iotI9XDtTwgiVmqFGzqwz10L67XVoyiTmJVoHX87QtqvcXgUnb0AC8"), completed: nil)
    }
    
}
