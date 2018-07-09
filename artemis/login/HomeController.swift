//
//  LoginController.swift
//  youtube
//
//  Created by Gustavo Tufiño Fernandez on 7/4/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController{
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor.primaryDarkColor()
        view.addSubview(statusBarView)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Asistencia"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.title()
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor.primaryDarkColor()
        view.addSubview(statusBarView)
        
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.primaryDarkColor()
        window?.addSubview(statusBarBackgroundView)
        
        let size:String = ScreenHelper.create().getDevice()
        window?.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithFormat(format: "V:|[v0(\(size))]", views: statusBarBackgroundView)
    }
    
}

