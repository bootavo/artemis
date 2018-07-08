//
//  LoginView.swift
//  youtube
//
//  Created by Gustavo Tufiño Fernandez on 7/4/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIViewController{
    
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
 */
    
    var logoImageViewTopConstraint: Constraint? = nil
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bg_login")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let empezemosButton: UIButton = {
        let button = UIButton()
        let title = NSMutableAttributedString(attributedString: NSAttributedString(string: "Iniciar Sesión", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.placeHolder() ]))
        
        button.setAttributedTitle(title, for: .normal)
        button.backgroundColor = UIColor.primaryDarkColor()
        button.setTitleColor(UIColor.primaryColor(), for: .normal)
        button.setAnchor(width: 0, height: 40)
        //button.layer.cornerRadius = button.bounds.size.width/2
        button.setAnchor(width: 0, height: 40)
        button.alpha = 1
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    let userName: UITextField = {
        let user = UITextField()
        user.borderStyle = .none
        user.layer.cornerRadius = 10
        user.backgroundColor = UIColor.primaryColor()
        user.textColor = UIColor.title()
        user.font = UIFont.systemFont(ofSize: 20)
        user.autocorrectionType = .no
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "usuario", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.setAnchor(width: 0, height: 40)
        user.textAlignment = .center
        return user
    }()
    
    let password: UITextField = {
        let user = UITextField()
        user.borderStyle = .none
        user.layer.cornerRadius = 10
        user.backgroundColor = UIColor.primaryColor()
        user.textColor = UIColor.title()
        user.font = UIFont.systemFont(ofSize: 20)
        user.autocorrectionType = .no
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Contraseña", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.placeHolder() ]))
        user.attributedPlaceholder = placeHolder
        user.textAlignment = .center
        user.setAnchor(width: 0, height: 40)
        
        return user
    }()
    
    @objc func login() {
        print("login")
    }
    
    func setup(){
        
        //Add background
        let stackView = mainStackView()
        
        self.view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self.view)
            
        }
        
        //self.view.addSubview(stackView)
        
        /*backgroundImageView.setAnchor(top: .topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0)
         */
        
        /*self.empezemosButton.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0)*/
        
        self.view.addSubview(userName)
        let viewHeight = self.view.frame.height
        let centerY = viewHeight / 2.0
        let topImageOffSet = centerY - 20

        userName.snp.makeConstraints{
            (make) -> Void in
            make.centerX.equalToSuperview()
            make.width.equalTo(128)
            make.height.equalTo(40)
            self.logoImageViewTopConstraint = make.top.equalToSuperview().offset(topImageOffSet).constraint

        }
        
        //stackView.setAnchor(width: self.frame.width-20, height: 150)
        //stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews:[userName, password, empezemosButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }
    
}
