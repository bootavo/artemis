//
//  AssistanceController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class AssistanceController: UIViewController{
    
    var assistanceView: AssistanceView!
    
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
    
}
