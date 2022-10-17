//
//  MovieDetailsUIViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 17.10.2022.
//

import UIKit
import WebKit


class FullScreenWKWebView: WKWebView {
    override var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


class MovieDetailsUIViewController: UIViewController {
    
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
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
    
    private let overviewLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0

        return label
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

    
    private let webView: WKWebView = {
       let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        view.addSubview(playButton)
        
        makeConstraints()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "purpleGradient.png")!)
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.tintColor = UIColor.white

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func makeConstraints() {
        let webviewConstrains = [
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            webView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2.7)
        ]
        
        let titleLabelConstrains = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let overviewLabelConstrains = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstrains = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 20),
            downloadButton.heightAnchor.constraint(equalToConstant: 48),
            downloadButton.widthAnchor.constraint(equalToConstant: 54)
        ]
        
        let playbuttonButtonConstrains = [
            playButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playButton.heightAnchor.constraint(equalToConstant: 48),
            playButton.widthAnchor.constraint(equalToConstant: view.frame.size.width - 104)
        ]
        
        NSLayoutConstraint.activate(webviewConstrains)
        NSLayoutConstraint.activate(titleLabelConstrains)
        NSLayoutConstraint.activate(overviewLabelConstrains)
        NSLayoutConstraint.activate(downloadButtonConstrains)
        NSLayoutConstraint.activate(playbuttonButtonConstrains)
    }
    
    func configure(with model: MovieDetailViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubePreview.id.videoId)") else { return }
        
        DispatchQueue.main.async { [self] in
            webView.load(URLRequest(url: url))
        }
    }


}
