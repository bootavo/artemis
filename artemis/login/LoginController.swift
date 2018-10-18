//
//  ViewController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/5/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import Toast
import SwiftyUserDefaults

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
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        if NetworkHelper.isConnectedToNetwork() {
            let user = self.loginView.tf_username.text
            let pass = self.loginView.tf_password.text
            let accessToken = "TVNfTE9HSU46VkYkQ09OU1VMVElOR19MT0dJTg=="
            if user == "" || pass == "" {
                print("Ingrese su usuario y/o contraseña")
                self.view.makeToast("Ingrese su usuario y/o contraseña")
                //self.alerta(mensaje: "Ingrese su usuario y/o contraseña")
            }else {
                let parameters = ["username" : user!,"password" : pass!]
                
                ApiService.sharedInstance.login(parameters: parameters) { (err, statusCode, json) in
                    if let error = err {
                        print(error)
                        UIViewController.removeSpinner(spinner: sv)
                        self.view.makeToast("Verifique su conexión a internet")
                        return
                    }
                    print(statusCode)
                    if let json = json {
                        let user = json["usuario"]
                        do {
                            let user = try JSONDecoder().decode(UserModel.self, from: user.rawData())
                            //Save data similar to SharedPreferences
                            Defaults[.employee_code] = user.employee_code!
                            Defaults[.name] = user.name!
                            Defaults[.patternLastName] = user.patternLastName!
                            Defaults[.matternLastName] = user.matternLastName!
                            
                            if user.foto != nil{
                                Defaults[.foto] = user.foto!
                                print("photo login: \(Defaults[.foto]!)")
                            }
                            
                            for module in user.modules! {
                                print("Modulo: \(module.vch_nom_modulo!)")
                                print("-----------------")
                                switch module.vch_nom_modulo! {
                                    case Constants.MODULE_ASSISTANCE: Defaults[.moduleAssistance] = Constants.MODULE_ASSISTANCE
                                    case Constants.MODULE_REPORT: Defaults[.moduleReport] = Constants.MODULE_REPORT
                                    case Constants.MODULE_ACTIVITY: Defaults[.moduleActivity] = Constants.MODULE_ACTIVITY
                                    case Constants.MODULE_PROJECT: Defaults[.moduleProject] = Constants.MODULE_PROJECT
                                    case Constants.MODULE_USER: Defaults[.moduleUser] = Constants.MODULE_USER
                                default: break
                                }
                            }
                            
                            print("save data")
                            self.pushToNextVC()
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.view.makeToast("Datos incorrectos")
                            UIViewController.removeSpinner(spinner: sv)
                        }
                    }
                }
            }
        }else {
            let toastPosition = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height - 60)
            self.view.makeToast("Verifique la conexión a internet", duration: 1.0, position: toastPosition)
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    func verifyUser() {
        if let code = Defaults[.employee_code], let _ = Defaults[.name], let _ = Defaults[.patternLastName], let _ = Defaults[.matternLastName] {
            if code != "" {
                pushToNextVC()
            }
        }
    }
    
    func alerta(mensaje:String) {
        let alert = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func pushToNextVC() {
        let newVC = TabBarController()
        newVC.navigationItem.hidesBackButton = true;
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
}

