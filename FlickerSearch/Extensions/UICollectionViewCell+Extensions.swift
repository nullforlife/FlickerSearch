//
//  UICollectionViewCell+Extensions.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
