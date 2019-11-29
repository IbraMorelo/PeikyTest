//
//  UICollectionView.swift
//  Alamofire
//
//  Created by Ibrahimme Morelo on 11/28/19.
//

import UIKit

extension UICollectionView {
    func reuse<T: UICollectionViewCell>(at index: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: index) as? T else {
            return T()
        }
        return cell
    }
}
