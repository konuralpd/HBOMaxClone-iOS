//
//  SearchResultsViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    public var contents: [MovieResult] = []
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 5, height: 240)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        view.addSubview(searchResultsCollectionView)

    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
 
  
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        let movie = contents[indexPath.row]
        cell.configure(with: movie.posterPath ?? "")
        cell.contentImageView.layer.cornerRadius = 4
        cell.contentImageView.clipsToBounds = true
        cell.layer.shadowColor = UIColor(named: "softPurple")?.cgColor
        cell.layer.shadowRadius = 15
        cell.layer.shadowOpacity = 0.5
        cell.contentImageView.clipsToBounds = true
        let playButton = UIButton(frame: CGRect(x: 75, y: 75, width: 64, height: 64))
        playButton.setImage(UIImage(named: "play"), for: .normal)
        cell.addSubview(playButton)
        
        return cell
    }
    
    
}
