//
//  ViewController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/5/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var loginView: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //NavigationBar
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        //Title Satus Bar White
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
    }
    
    func setupView(){
        loginView = LoginView(frame: self.view.frame)
        self.view.addSubview(loginView)
        loginView.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self.view)
        }
        self.loginView.loginAction = login
    }
    
    func login(){
        print("login")
        if self.loginView.verifyLogin() {
            self.view.makeToast("Go")
            let activityController = ActivityController()
            //present(activityController, animated: true, completion: nil)
            self.navigationController?.pushViewController(activityController, animated: true)
        }else {
            self.view.makeToast("Complete sus datos")
        }
    }

}

