//
//  HeaderView.swift
//  DemoWeatherApp-Swift
//
//  Created by Pavel on 3.04.23.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    private let locationLabel: UILabel = {
        let location = UILabel()
        location.text = "Sofia"
        location.font = .systemFont(ofSize: 24, weight: .light)
        location.textColor = .white
        location.textAlignment = .center
        return location
    }()
    
    private let degreesLabel: UILabel = {
        let degrees = UILabel()
        degrees.text = "Degrees°C"
        degrees.font = .systemFont(ofSize: 42, weight: .regular)
        degrees.textColor = .white
        degrees.textAlignment = .center
        return degrees
    }()
    
    private let weatherCodeLabel: UILabel = {
        let weatherCode = UILabel()
        weatherCode.text = "WeatherCode"
        weatherCode.font = .systemFont(ofSize: 24, weight: .light)
        weatherCode.textColor = .white
        weatherCode.textAlignment = .center
        return weatherCode
    }()
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: Constants.headerIdentifier)
        contentView.addSubview(locationLabel)
        contentView.addSubview(degreesLabel)
        contentView.addSubview(weatherCodeLabel)
        contentView.backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        locationLabel.sizeToFit()
        degreesLabel.sizeToFit()
        weatherCodeLabel.sizeToFit()
        
        locationLabel.frame = CGRect(x: 0,
                                     y: contentView.frame.minY + locationLabel.frame.size.height,
                             width: contentView.frame.size.width,
                             height: locationLabel.frame.size.height)
        degreesLabel.frame = CGRect(x: 0,
                             y: locationLabel.frame.origin.y + locationLabel.frame.size.height + 5,
                             width: contentView.frame.size.width,
                             height: degreesLabel.frame.size.height)
        
        weatherCodeLabel.frame = CGRect(x: 0,
                                        y: degreesLabel.frame.maxY + 5,
                                        width: contentView.frame.size.width,
                                        height: weatherCodeLabel.frame.size.height)
        
    }
    
    func updateHeader(location: String) {
        print("in \(location)")
        locationLabel.text = location
    }
    
    func updateHeader(degrees: String, weatherCode: String) {
        degreesLabel.text = degrees
        weatherCodeLabel.text = weatherCode
    }
}
