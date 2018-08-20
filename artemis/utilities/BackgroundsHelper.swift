//
//  UIBackgroundsHelper.swift
//  artemis
//
//  Created by VF Consulting on 8/08/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class BackgroundHelper {

    var view: UIView?
    
    var message: String?
    
    required init(v: UIView, message: String?) {
        print("ENTROOOOOOOOOOOO AL INIT DEL BACKGROUND HELPER")
        self.view = v
        self.message = message
        setupViews(view: view!)
    }
    
    func setupViews(view: UIView){
        print("ENTROOOOOOOOOOOO AL SETUPVIEW")

        view.addSubview(iv_background)
        iv_background.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(250)
            make.height.equalTo(250)
            make.topMargin.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tv_message)
        tv_message.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.topMargin.equalTo(320)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(iv_icon)
        iv_icon.snp.makeConstraints{
            (make) -> Void in
            make.top.bottom.equalTo(tv_message).offset(60)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
    
    let iv_background: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "ic_disconnect")
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        return iv
    }()
    
    let tv_message: UITextView = {
        var tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textAlignment = .center
        tv.textColor = UIColor.gray
        tv.isHidden = true
        return tv
    }()
    
    let iv_icon: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "ic_refresh_icon")
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        return iv
    }()
    
    func showNetworkProblems(state: Bool){
        iv_background.image = UIImage(named: "ic_disconnect")
        tv_message.text = "Problemas de conexión a Internet \n Desliza hacia abajo para actualizar"
        if state {
            iv_background.isHidden = false
            tv_message.isHidden = false
            iv_icon.isHidden = false
        }else {
            iv_background.isHidden = true
            tv_message.isHidden = true
            iv_icon.isHidden = true
        }
    }
    
    func showDataEmpty(state: Bool){
        iv_background.image = UIImage(named: "bg_no_data")
        tv_message.text = "No se encontró información \n Desliza hacia abajo para actualizar"
        if state {
            iv_background.isHidden = false
            tv_message.isHidden = false
            iv_icon.isHidden = false
        }else {
            iv_background.isHidden = true
            tv_message.isHidden = true
            iv_icon.isHidden = true
        }
    }
    
    func showServerError(state: Bool){
        iv_background.image = UIImage(named: "bg_error_500")
        tv_message.text = "Lo sentimos, tenemos inconvenientes \n Desliza hacia abajo para actualizar"
        if state {
            iv_background.isHidden = false
            tv_message.isHidden = false
            iv_icon.isHidden = false
        }else {
            iv_background.isHidden = true
            tv_message.isHidden = true
            iv_icon.isHidden = true
        }
    }
    
    func showErrorNotAllowed(state: Bool){
        iv_background.image = UIImage(named: "bg_error_notallow")
        tv_message.text = "Problemas con la información \n Desliza hacia abajo para actualizar"
        if state {
            iv_background.isHidden = true
            tv_message.isHidden = true
            iv_icon.isHidden = true
        }else {
            iv_background.isHidden = false
            tv_message.isHidden = false
            iv_icon.isHidden = false
        }
    }
    
}
