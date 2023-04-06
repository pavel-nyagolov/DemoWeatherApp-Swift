//
//  ViewController.swift
//  DemoWeatherApp-Swift
//
//  Created by Pavel on 3.04.23.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationButton: UIButton!
    
    var header: HeaderView?
    var loadingView = LoadingView()
    var refreshDataControl: UIRefreshControl?
    
    var weatherObject = WeatherRequestManager(location: .sofia)
    var weatherModel: [DataType: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.headerIdentifier)
        startSpinner()
        addRefreshControl()
        
        
        locationButton.menu = UIMenu(children: [
            UIAction(title: "Sofia", handler: {(_) in
                self.changeLocation(location: .sofia)
            }),
            UIAction(title: "Varna", handler: {(_) in
                self.changeLocation(location: .varna)
            }),
            UIAction(title: "Burgas", handler: {(_) in
                self.changeLocation(location: .burgas)
            }),
            UIAction(title: "Plovdiv", handler: {(_) in
                self.changeLocation(location: .plovid)
            })
        ])
        
        NotificationCenter.default.addObserver(forName: .updateDataNotification, object: nil, queue: OperationQueue.main) { _ in
            self.reloadDataOnScreen()
            self.refreshDataControl?.endRefreshing()
            self.stopSpinner()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weatherObject.getWeatherData()
    }
    
    func changeLocation(location: Location) {
        startSpinner()
        switch location {
        case .varna:
            header?.updateHeader(location: "Varna")
            weatherObject = WeatherRequestManager(location: .varna)
            weatherObject.getWeatherData()
        case .sofia:
            header?.updateHeader(location: "Sofia")
            weatherObject = WeatherRequestManager(location: .sofia)
            weatherObject.getWeatherData()
        case .burgas:
            header?.updateHeader(location: "Burgas")
            weatherObject = WeatherRequestManager(location: .burgas)
            self.weatherObject.getWeatherData()
        case .plovid:
            header?.updateHeader(location: "Plovdiv")
            weatherObject = WeatherRequestManager(location: .plovid)
            self.weatherObject.getWeatherData()
        }
    }
    
    func addRefreshControl(){
        refreshDataControl = UIRefreshControl()
        refreshDataControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshDataControl!)
    }
    
    @objc func refresh(sender: UIRefreshControl){
        weatherObject.getWeatherData()
    }
    
    func reloadDataOnScreen() {
        weatherModel = weatherObject.weatherModel
        header?.updateHeader(degrees: "\(weatherModel![.temperature] as! Double)°C", weatherCode: weatherObject.getWeatherCode().rawValue)
        
        switch weatherObject.getWeatherCode() {

        case .clearSky:
            backgroundImage.image = Constants.clearSky
        case .cloudy:
            backgroundImage.image = Constants.cloud
        case .fog:
            backgroundImage.image = Constants.fog
        case .drizzle:
            backgroundImage.image = Constants.rain
        case .rain:
            backgroundImage.image = Constants.rain
        case .snowFall:
            backgroundImage.image = Constants.snow
        case .rainShowers:
            backgroundImage.image = Constants.rain
        case .snowShowers:
            backgroundImage.image = Constants.snow
        case .thunderstorm:
            backgroundImage.image = Constants.thunder
        case .unknown:
            backgroundImage.image = nil
        }
        
        tableView.reloadData()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = weatherModel?.count else {
            return 0
        }
        return count - 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.weatherCell, for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Wind Direction"
            cell.detailTextLabel?.text = String((weatherModel![.windDirection] as? Double)!)
            cell.imageView?.image = nil
        case 1:
            cell.textLabel?.text = "Wind Speed"
            cell.detailTextLabel?.text = String((weatherModel![.windSpeed] as? Double)!)
            cell.imageView?.image = nil
        case 2:
            cell.textLabel?.text = "Pressure"
            cell.detailTextLabel?.text = String((weatherModel![.pressure] as? Double)!)
            cell.imageView?.image = nil
        case 3:
            cell.textLabel?.text = "Humidity"
            cell.detailTextLabel?.text = String((weatherModel![.humidity] as? Double)!)
            cell.imageView?.image = nil
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.headerIdentifier) as? HeaderView
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 200 : 0
    }
}

extension WeatherViewController {
    func startSpinner() {
        
        loadingView.spinnerView = UIView(frame: self.view.bounds)
        
        loadingView.blurEffectView = UIVisualEffectView(effect: loadingView.blurEffect)
        loadingView.blurEffectView?.frame = self.view.bounds
        loadingView.blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        loadingView.spinner.center = loadingView.spinnerView!.center
        loadingView.spinner.startAnimating()
        loadingView.spinnerView!.addSubview(loadingView.spinner)
        
        let textLabel = UILabel(frame: CGRect(x: 0,
                                              y: self.loadingView.spinner.frame.midY + 24,
                                              width: self.view.frame.width,
                                              height: 20))
        
        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 16, weight: .ultraLight)
        textLabel.text = "Loading..."
        
        loadingView.spinnerView?.addSubview(textLabel)
        
        self.view.addSubview(loadingView.blurEffectView!)
        self.view.addSubview(loadingView.spinnerView!)
    }
    
    func stopSpinner() {
        loadingView.blurEffectView?.removeFromSuperview()
        loadingView.blurEffectView = nil
        
        loadingView.spinnerView?.removeFromSuperview()
        loadingView.spinnerView = nil
    }
}
