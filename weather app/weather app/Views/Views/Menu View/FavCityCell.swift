//
//  FavCityCell.swift
//  weather app
//
//  Created by Prahash Barman on 24/06/25.
//

import UIKit

protocol FavouriteCitySelectionDelegate {
    func didSelectFavouriteCity(cityName: String)
    func didSetHomeCity(cityName: String)
}

class FavCityCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel?
    @IBOutlet weak var favouriteButton: UIButton?
    var delegate: FavouriteCitySelectionDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        delegate?.didSelectFavouriteCity(cityName: cityNameLabel?.text ?? "Greenwich")
    }
}



class ExpandedFavCityCell: FavCityCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func unfavouriteButtonTapped(_ sender: Any) {
        delegate?.didSelectFavouriteCity(cityName: cityNameLabel?.text ?? "Greenwich")
    }
    
    @IBAction func setHomeButtonTapped(_ sender: Any) {
        delegate?.didSetHomeCity(cityName: cityNameLabel?.text ?? "Greenwich")
    }
}
