//
//  Extensions.swift
//  HBOMaxClone
//
//  Created by Mac on 16.10.2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
