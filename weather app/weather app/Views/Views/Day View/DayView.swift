//
//  DayView.swift
//  weather app
//
//  Created by Prahash Barman on 21/06/25.
//

import UIKit

class DayView: UIView {
    
    @IBOutlet weak var descriptionStack: UIStackView?
    @IBOutlet weak var location: UILabel?
    @IBOutlet weak var temp: UILabel?
    @IBOutlet weak var summary: UILabel?
    @IBOutlet weak var descriptorImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.location?.text = "Guwahati"
        self.temp?.text = "26° C"
    }
    
}



