//
//  ViewController.swift
//  analytics-demo
//
//  Created by Makoto Shimizu on 2018/06/17.
//  Copyright © 2018 mak. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ADBMobile.trackState("Top", data: nil)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            ADBMobile.trackLocation(location, data: nil)
        }
    }

    @IBAction func powerBtnPressed(_ sender: Any) {
        var contextData: [String: String] = [:]
        contextData["userID"] = "abc123"
        
        powerBtn.isHidden = true
        
        self.webView.isHidden = false
            
        let url = URL(string: "https://makoto-shimizu.com/")
        let urlWithVisitorData = ADBMobile.visitorAppend(to: url)
        let request = URLRequest(url: urlWithVisitorData!)
        self.webView.load(request)
        
        ADBMobile.trackAction("WebView1", data: contextData)
        
    }
    
}
