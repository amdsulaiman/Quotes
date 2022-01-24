//
//  QuotesTableViewCell.swift
//  Quotes
//
//  
//

import UIKit

class QuotesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var quotesContentLbl: UILabel!
    @IBOutlet weak var authorNameLbl: UILabel!
    @IBOutlet weak var favouritesBtnRef: UIButton!
    var favouriteQuote:(() -> ())?
    static let identifier = "QuotesTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
        return UINib(nibName: "QuotesTableViewCell", bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   @IBAction func favouritesBtnAction(_ sender: UIButton) {
        self.favouriteQuote?()
    }
}
