//
//  ExploreCollectionViewCell.swift
//  Quotes
//
//  
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {

    static let identifier = "ExploreCollectionViewCell"
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var quotesCountLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "ExploreCollectionViewCell", bundle: nil)
    }

}
