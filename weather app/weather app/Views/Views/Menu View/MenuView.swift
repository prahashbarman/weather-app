//
//  MenuView.swift
//  weather app
//
//  Created by Prahash Barman on 23/06/25.
//

import UIKit

class MenuView: UIView {    
    @IBOutlet weak var welcomeLabel: UILabel?
    @IBOutlet weak var menuTable: UITableView?
    @IBOutlet weak var versionLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        menuTable?.register(UINib(nibName: "FavCityCell", bundle: Bundle.main), forCellReuseIdentifier: "favCityCell")
        menuTable?.register(UINib(nibName: "ExpandedFavCityCell", bundle: Bundle.main), forCellReuseIdentifier: "expandedFavCityCell")
        if let version: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel?.text = "App Version: v" + version
        }
    }
}
