//
//  onboardCollectionViewCell.swift
//  Quotes
//
//  
//

import UIKit

class onboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var onBoardImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func setup(_ slide : OnboardingSlide) {
        onBoardImg.image = slide.image
        titleLabel.text = slide.title
        subTitleLabel.text = slide.description
    }
    
}
