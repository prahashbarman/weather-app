//
//  HomeScreenVC.swift
//  weather app
//
//  Created by Prahash Barman on 21/06/25.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    var menuTableView: UITableView?
    var menuViewWidthExtended: Bool = false
    var menuViewLeadingConstraint: NSLayoutConstraint?
    private var dayView: DayView?
    private var viewModel: HomeScreenVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeScreenVM(delegate: self)
        
        //TODO: update view model from saved data
        
        setupDayView()
        setupMenuView()
    }
    
    private func setupDayView() {
        let dayViewNib = UINib(nibName: "DayView", bundle: Bundle.main)
        if let dayView = dayViewNib.instantiate(withOwner: nil, options: nil).first as? DayView {
            self.dayView = dayView
            view.addSubview(dayView)
            dayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
            dayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
            dayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
            dayView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            dayView.descriptorImage?.layer.cornerRadius = 8
            dayView.layer.cornerRadius = 12
            dayView.layer.masksToBounds = true
        }
    }
    
    private func setupMenuView() {
        let menuViewNib = UINib(nibName: "MenuView", bundle: Bundle.main)
        if let menuView = menuViewNib.instantiate(withOwner: nil, options: nil).first as? MenuView {
            view.addSubview(menuView)
            menuViewLeadingConstraint = menuView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                                          constant: -view.frame.width * 0.4)
            menuView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.4).isActive = true
            menuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            
            menuViewWidthExtended = false
            menuViewLeadingConstraint?.isActive = true
            
            let swipeToDismiss: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeToDismiss.direction = .left
            view.addGestureRecognizer(swipeToDismiss)
            
            menuTableView = menuView.menuTable
            menuTableView?.delegate = self
            menuTableView?.dataSource = self
        }
    }
    
    //MARK: User Interaction Handlers
    @IBAction func menuButtonTapped(_ sender: Any?) {
        if menuViewWidthExtended {
            menuViewWidthExtended = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.menuViewLeadingConstraint?.constant = -(self?.view.frame.width ?? 420.0) * 0.4
                self?.view.layoutIfNeeded()
            }
        } else {
            menuViewWidthExtended = true
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.menuViewLeadingConstraint?.constant = 0.0
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any?) {
        
    }
    
    @IBAction func showDetailForecastedWeather(_ sender: Any?) {
        let forecastView: UIViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForecastView")
        self.navigationController!.pushViewController(forecastView, animated: true)
    }
   
    @objc func handleGesture() {
        if menuViewWidthExtended {
            menuButtonTapped(nil)
        }
    }
}

//MARK: Table View Data Source And Delegate Extension
extension HomeScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.favouriteCities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavCityCell = menuTableView?.dequeueReusableCell(withIdentifier: "favCityCell") as? FavCityCell ?? FavCityCell()
        guard indexPath.row < viewModel?.favouriteCities.count ?? 0 else { return cell }
        cell.cityNameLabel?.text = viewModel?.favouriteCities[indexPath.row]
        return cell
    }
}

//MARK: HomeScreenVMDelegate Extension
extension HomeScreenVC: HomeScreenVMDelegate {
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.assignValues()
            self?.view.layoutIfNeeded()
        }
    }
    
    func assignValues() {
        dayView?.location?.text = viewModel?.dayViewModel?.cityName
        dayView?.temp?.text = String(viewModel?.dayViewModel?.currentTemp ?? 0.0)
        dayView?.summary?.text = viewModel?.dayViewModel?.weatherDescription
        dayView?.descriptorImage?.image = viewModel?.dayViewModel?.image?.withTintColor(#colorLiteral(red: 0.6864583492, green: 0.9764811397, blue: 0.9336461425, alpha: 1))
    }
}
