//
//  CommonCollectionViewCell.swift
//  Quotes
//
//
//

import UIKit

class CommonCollectionViewCell: UICollectionViewCell {
    static let identifier = "CommonCollectionViewCell"
    
    @IBOutlet weak var bgView: RCustomView!
    @IBOutlet weak var fontTextLbl: UILabel!
    @IBOutlet weak var titleFontLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    static func nib() -> UINib {
        return UINib(nibName: "CommonCollectionViewCell", bundle: nil)
    }
}
