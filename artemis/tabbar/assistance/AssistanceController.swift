//
//  AssistanceController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class AssistanceController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupMenuBar()
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
        titleLabel.textColor = UIColor.title()
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
           // make.top.equalTo().offset(0)
            //make.width.equalToSuperview()
            //make.height.equalTo(50)
            //make.top.bottom.equalTo(self.view).offset(0)
            //make.right.lessThanOrEqualTo(20)
        }
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
}
