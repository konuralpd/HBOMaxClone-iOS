//
//  SideMenuView.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import UIKit

class SideMenuView: UIView {

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .black
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height)
    }

}
