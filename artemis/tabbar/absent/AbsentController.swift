//
//  AbsentController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class AbsentController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
        self.navigationController?.navigationBar.shadowImage = nil
        
        //Title Status Bar White
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Reportes"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.title()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
    }
    
}
