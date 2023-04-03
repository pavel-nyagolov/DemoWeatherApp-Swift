//
//  LoadingView.swift
//  DemoWeatherApp-Swift
//
//  Created by Pavel on 3.04.23.
//

import UIKit

struct LoadingView {
    var spinnerView: UIView?
    var blurEffectView: UIVisualEffectView?
    
    var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    var spinner = UIActivityIndicatorView(style: .large)
}
