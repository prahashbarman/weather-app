//
//  FavCityCell.swift
//  weather app
//
//  Created by Prahash Barman on 24/06/25.
//

import UIKit

class FavCityCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel?
    @IBOutlet weak var favouriteButton: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class ExpandedFavCityCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
