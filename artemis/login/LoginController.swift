//
//  ViewController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/5/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import Toast

class LoginController: UIViewController, UIApplicationDelegate {
    
    var loginView: LoginView!
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        //NavigationBar
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
            //self.navigationController?.pushViewController(activityController, animated: true)
            //present(TabBarController(), animated: true, completion: nil)
            
            //let vc = TabBarController()
            //self.present(vc, animated: true, completion: nil)
            
            print("\(loginView.tf_username.text!)")
            print("\(loginView.tf_password.text!)")
            
            if loginView.tf_username.text! == "gustavo.tufino@vfcons.com" && loginView.tf_password.text! == "STAFF2018" {
                pushToNextVC()
            }else{
                self.loginView.makeToast("Datos incorrectos")
            }
            
        }else {
            self.view.makeToast("Complete sus datos")
        }
    }
    
    func pushToNextVC() {
        let newVC = TabBarController()
        newVC.navigationItem.hidesBackButton = true;
        self.navigationController?.pushViewController(newVC, animated:
            true)
    }

}

