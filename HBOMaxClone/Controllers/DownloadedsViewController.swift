//
//  DownloadedsViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit

class DownloadedsViewController: UIViewController {

    var savedContents: [ContentItem] = []
    private let downloadedTable: UITableView = {
       let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Kaydedilenler"
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        getLocalStorageDownloadeds()
        view.addSubview(downloadedTable)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
    
    private func getLocalStorageDownloadeds() {
        DataPersistenceManager.shared.fetchingSavedContentsFromDatabase { result in
            switch result {
            case .success(let movies):
                self.savedContents = movies
                print(movies[0].poster_path)
                DispatchQueue.main.async {
                    self.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension DownloadedsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as?
                ContentTableViewCell else { return UITableViewCell() }
        
        let content = savedContents[indexPath.row]
        let model = ContentViewModel(titleName: content.name ?? "İsim Bilgisi Yok", posterUrl:content.poster_path ?? "")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}
