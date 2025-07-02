//
//  ForecastedWeatherViewController.swift
//  weather app
//
//  Created by Prahash Barman on 30/06/25.
//

import UIKit

class ForecastedWeatherViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Forecasted Weather"

        let font = UIFont(name: "Copperplate-Light", size: 14)!
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        segmentedControl?.setTitleTextAttributes(attributes, for: .normal)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
