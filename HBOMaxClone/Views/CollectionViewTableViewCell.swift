//
//  CollectionViewTableViewCell.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit


protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MovieDetailViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    private var contents = [MovieResult]()
    var isCurrentWatching: Bool = false
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 240, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
   
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with movies: [MovieResult]) {
        self.contents = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
    }
    
    private func downloadContentAt(indexPath: IndexPath) {
        DataPersistenceManager.shared.downloadContentWith(model: contents[indexPath.row]) { result in
            switch result {
            case .success():
                print("downloaded")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: contents[indexPath.row].posterPath ?? "")
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        if isCurrentWatching == true {
            let randomInt = Int.random(in: 80..<Int(cell.frame.size.width))
            let template = UIView(frame: CGRectMake(0, 144, cell.frame.size.width - CGFloat(randomInt), 6))
            template.backgroundColor = UIColor(patternImage: UIImage(named: "loading")!)
            cell.addSubview(template)
        }
        let playButton = UIButton(frame: CGRect(x: 75, y: 50, width: 64, height: 65))
        playButton.setImage(UIImage(named: "play"), for: .normal)
        cell.addSubview(playButton)
        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let content = contents[indexPath.row]
        guard let contentName = content.originalName else { return }
        
        
        APIManager.shared.getContentVideo(with: contentName + "trailer") { [self] result in
            switch result {
            case .success(let videoElement):
                let viewModel = MovieDetailViewModel(title: content.originalName ?? "", youtubePreview: videoElement, titleOverview: content.overview!)
                delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            
            let downloadAction = UIAction(title: "Daha Sonra İzlemek İçin Kaydet", subtitle: nil, image: UIImage(named: "download")?.withRenderingMode(.alwaysTemplate), identifier: nil,
                                          discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadContentAt(indexPath: indexPaths[0])
            }
            
            let iDontWantToSeeAction = UIAction(title: "Bunu Görmek İstemiyorum", subtitle: nil, image: UIImage(named: "dislike")?.withRenderingMode(.alwaysTemplate), identifier: nil,
                                          discoverabilityTitle: nil, state: .off) { _ in
                
                
               
            }
            
            
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction,iDontWantToSeeAction])
        }
        return config
    }
}
