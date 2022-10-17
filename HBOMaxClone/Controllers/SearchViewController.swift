//
//  SearchViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit

class SearchViewController: UIViewController {

    
    var contents = [DiscoverResults]()
    private let searchTable: UITableView = {
       let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "İçeriklerimizde Ara"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "İçeriklerde Ara"
        navigationController?.navigationBar.prefersLargeTitles = false
     
        view.addSubview(searchTable)
        searchTable.delegate = self
        searchTable.dataSource = self
        
        fetchFeaturedMovies()
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: "purpleGradient2.png")!)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white], for: .normal)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
    }
    
    private func fetchFeaturedMovies() {
        APIManager.shared.getDiscoverMovies { [self] result in
            switch result {
            case .success(let movies):
                self.contents = movies
                DispatchQueue.main.async {
                    self.searchTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

   

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = contents[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell else { return UITableViewCell() }
        let model = ContentViewModel(titleName: movie.title ?? movie.originalTitle ?? "İsim Bilgisi Yok", posterUrl:movie.posterPath ?? "")
        cell.configure(with: model)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "softPurple")
        cell.selectedBackgroundView = backgroundView
        return cell
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text,
              !searchText.trimmingCharacters(in: .whitespaces).isEmpty,
              searchText.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        APIManager.shared.searchContent(with: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    resultController.contents = movies
                    resultController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
