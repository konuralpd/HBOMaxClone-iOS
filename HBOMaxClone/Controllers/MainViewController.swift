//
//  MainViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit
import SideMenu


enum Sections: Int {
    case İzlemeList = 0
    case HboOriginals = 1
    case OneCikanlar = 2
    case EnCokİzlenenler = 3
}

class MainViewController: UIViewController {
    
    let categoryTitles: [String] = ["İzlemeye Devam Edin","HBO Orijinaller"]
    
    var watchingList = [MovieResult]()
    
    private let mainFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        mainFeedTable.delegate = self
        mainFeedTable.dataSource = self
        mainFeedTable.showsVerticalScrollIndicator = false
     
        view.addSubview(mainFeedTable)
        
        
        let featuredView = FeaturedHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        mainFeedTable.tableHeaderView = featuredView
        getWatchingList()
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainFeedTable.frame = view.bounds
    }
    
    
//    private func getTrendingTvSeries() {
//        APIManager.shared.getTrendingTVSeries { results in
//            switch results {
//            case .success(let movies):
//                print(movies)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func getWatchingList() {
        APIManager.shared.getWatchingList { results in
            switch results {
            case .success(let movies):
                self.watchingList = movies
            case .failure(let error):
                print(error)
            }
        }
    }

 

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryTitles.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        
        
        
        switch indexPath.section {
        case Sections.İzlemeList.rawValue:
            APIManager.shared.getWatchingList { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                    cell.isCurrentWatching = true
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.HboOriginals.rawValue:
            APIManager.shared.getTrendingTVSeries { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.OneCikanlar.rawValue:
            APIManager.shared.getTrendingTVSeries { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.EnCokİzlenenler.rawValue:
            APIManager.shared.getTrendingTVSeries { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.localizedCapitalized
        header.textLabel?.textColor = .white
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension MainViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MovieDetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = MovieDetailsUIViewController()
            vc.configure(with: viewModel)
            let transition:CATransition = CATransition()
            transition.duration = 0.8
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            self?.navigationController?.view.layer.add(transition, forKey: kCATransition)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
