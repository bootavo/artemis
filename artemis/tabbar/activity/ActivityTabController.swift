//
//  ActivityController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ActivityTabController: UIViewController, UIApplicationDelegate{
    
    var activityView: ActivityView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        self.navigationController?.navigationBar.shadowImage = nil
        
        //Title Status Bar White
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Actividades"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
    }
    
    func setupView(){
        activityView = ActivityView(frame: self.view.frame)
        self.view.addSubview(activityView)
        activityView.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self.view)
        }
        self.activityView.saveAction = save
        self.activityView.doneAction = done
    }
    
    func save(){
        print("save")
    }
    
    func done(){
        print("done")
    }
    
}

