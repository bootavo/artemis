//
//  LoginController.swift
//  youtube
//
//  Created by Gustavo Tufiño Fernandez on 7/4/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit

class LoginController: UICollectionViewController{
    
    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
    }
    
    /*
    func setupView(){
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.view.addSubview(mainView)
        loginView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0)
    }
 */
    
}
