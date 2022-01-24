//
//  ExploreAuthorTableViewCell.swift
//  Quotes
//
//  
//

import UIKit

class ExploreAuthorTableViewCell: UITableViewCell {

     static let identifier = "ExploreAuthorTableViewCell"
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var authorSubTitleLbl: UILabel!
    @IBOutlet weak var quotesCountLbl: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib {
        return UINib(nibName: "ExploreAuthorTableViewCell", bundle: nil)
    }
    
}
