//
//  LoginView.swift
//  youtube
//
//  Created by Gustavo Tufiño Fernandez on 7/4/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView, UITextFieldDelegate{
    
    var offSet: Float = -60
    
    var screen: CGRect? = nil
    var screenWidth: CGFloat? = nil
    var screenHeight: CGFloat? = nil
    
    var loginAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        tf_username.text = "gustavo.tufino@vfcons.com"
        tf_password.text = "STAFF2018"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        self.tf_username.delegate = self
        self.tf_password.delegate = self
        
        screen = UIScreen.main.bounds
        screenWidth = screen!.size.width
        screenHeight = screen!.size.height
        print("\(screenWidth!)")
        print("\(screenHeight!)")
        
        addSubview(iv_background)
        iv_background.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self)
        }
        
        addSubview(tf_username)
        tf_username.snp.makeConstraints{
            (make) -> Void in
            make.topMargin.equalTo(350)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(tf_password)
        tf_password.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_username).offset(50)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(btn_login)
        btn_login.snp.makeConstraints{
            (make) -> Void in
            make.top.equalTo(tf_password).offset(70)
            make.width.equalToSuperview().offset(offSet)
            make.centerX.equalToSuperview()
        }
        
        addSubview(powered)
        powered.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(screenWidth!)
            make.bottomMargin.equalTo(0)
        }
        
        /*
        if ScreenHelper.create().getDevice() == Constants.DEVICE_IPHONE_X{
            addSubview(powered)
            powered.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(screenWidth!)
                make.bottom.bottomMargin.equalTo(-2sssss0)
                //make.bottom.equalTo(superview.snp_bottom).offset(-20)
            }
        }else {
            addSubview(powered)
            powered.snp.makeConstraints{ (make) -> Void in
                make.width.equalTo(screenWidth!)
                make.bottom.trailing.equalToSuperview().offset(0)
            }
        }
        */
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == tf_username{
            let limitLength = 25
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= limitLength
        }else if textField == tf_password {
            let limitLength = 20
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= limitLength
        }
        return true
    }
    
    let iv_background: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bg_login")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let tf_username: UITextField = {
        let tf = UITextField(placeholder: "Usuario")
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.keyboardType = UIKeyboardType.emailAddress
        tf.textColor = UIColor.black
        return tf
    }()
    
    let tf_password: UITextField = {
        let tf = UITextField(placeholder: "Contraseña")
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = UIColor.black
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let btn_login: RoundedButton = {
        let btn = RoundedButton()
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.setTitle(title: "INICIAR SESIÓN", color: UIColor.primaryColor())
        return btn
    }()
    
    let powered: FooterButton = {
        let btn = FooterButton()
        return btn
    }()
    
    @objc func login() {
        loginAction?()
    }
    
    func verifyLogin() -> Bool{
        if tf_username.text != "" || tf_password.text != "" {
            return true
        }else {
            return false
        }
    }
    
}
