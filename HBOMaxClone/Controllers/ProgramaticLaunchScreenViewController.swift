//
//  ProgramaticLaunchScreenViewController.swift
//  HBOMaxClone
//
//  Created by Mac on 17.10.2022.
//

import UIKit

class ProgramaticLaunchScreenViewController: UIViewController {

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

        view.backgroundColor = UIColor(patternImage: UIImage(named: "purpleGradient")!)
        
        view.addSubview(logoImageView)
        
        makeConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [self] in
            navigationController?.pushViewController(WhoIsWatchingViewController(), animated: true)
              }

    }
    
    private func  makeConstraints() {
        let logoImageViewConstraints = [
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 240),
            logoImageView.heightAnchor.constraint(equalToConstant: 80)
        ]


        NSLayoutConstraint.activate(logoImageViewConstraints)
    }

   
}
