//
//  AssistanceController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults
import Toast
import CoreLocation

class AssistanceController: UIViewController, CLLocationManagerDelegate{
    
    var assistanceView: AssistanceView!
    
    var locationManager = CLLocationManager()
    var lat:Double?
    var lng:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupMenuBar()
        configLocationManager()
        showTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Title Status Bar White
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Asistencia"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar(){
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(0)
        }
        //view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        //view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
        
        assistanceView = AssistanceView(frame: self.view.frame)
        self.view.addSubview(assistanceView)
        assistanceView.snp.makeConstraints{
            (make) -> Void in
            //make.edges.equalTo(self.view)
            make.width.equalToSuperview()
            make.top.bottom.equalTo(menuBar).offset(50)
        }
    }
    
    func configLocationManager(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            print("NotDetermined")
            break
            
        case .restricted, .denied:
            // Disable location features
            print("Restricted")
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            print("AuthorizedWhenInUse")
            locationManager.startUpdatingLocation()
            guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            lat = locValue.latitude
            lng = locValue.longitude
            break
        }
    }

    func showTimer(){
        self.setTimer()
        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            (_) in
            self.setTimer()
        }
    }
    
    
    func setTimer(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/d/MMM"
        var dateFormat = formatter.string(from: Date())
        
        let fullNameArr = dateFormat.components(separatedBy: "/")
        let day    = fullNameArr[0]
        let numberDay = fullNameArr[1]
        let month = fullNameArr[2]
        dateFormat = "\(day)\(numberDay)\(month)"
        
        var dateString = NSMutableAttributedString (string: "\(dateFormat)")
        let bigBoldFont = UIFont.boldSystemFont(ofSize: 18)
        dateString.addAttribute(NSForegroundColorAttributeName, value: bigBoldFont, range: NSMakeRange(location: 3,length: 2))
        
        let date = Date()
        let calendar = Calendar.current
        
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        if hours < 10 {
            self.assistanceView.tv_hour.text = "0\(hours)"
        }else {
            self.assistanceView.tv_hour.text = "\(hours)"
        }
        
        if minutes < 10 {
            self.assistanceView.tv_minutes.text = ":0\(minutes)"
        }else {
            self.assistanceView.tv_minutes.text = ":\(minutes)"
        }
        
        self.assistanceView.tv_date.attributedText = "\(dateString)"
    }
    
}
