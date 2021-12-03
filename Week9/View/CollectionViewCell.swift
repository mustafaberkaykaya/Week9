//
//  CollectionViewCell.swift
//  Week9
//
//  Created by Mustafa Berkay Kaya on 30.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func setImageView() -> UIImageView {
        return imageView
    }
    
    func setTitleLabel() -> UILabel {
        return titleLabel
    }
}
