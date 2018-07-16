//
//  AssistanceView.swift
//  artemis
//
//  Created by VF Consulting on 7/11/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class AssistanceView: UIView {
    
    var loginAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) AssistanceView has not been implemented")
    }
    
    func setup(){
        
        addSubview(iv_circle)
        iv_circle.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(250)
            make.height.equalTo(250)
            make.topMargin.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        addSubview(btn_assistance)
        btn_assistance.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(280)
            make.height.equalTo(40)
            make.topMargin.equalTo(400)
            make.centerX.equalToSuperview()
        }
        addSubview(tv_hour)
        tv_hour.text = "17"
        tv_hour.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.topMargin.equalTo(200)
            make.centerX.equalToSuperview().offset(-30)
        }
        
        addSubview(tv_minutes)
        tv_minutes.text = ":50"
        tv_minutes.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.topMargin.equalTo(200)
            make.centerX.equalToSuperview().offset(37)
        }
        
        addSubview(tv_date)
        tv_date.text = "Mar 26 Jun"
        tv_date.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.topMargin.equalTo(250)
            make.centerX.equalToSuperview()
        }
        
        //Another
        addSubview(iv_network)
        iv_network.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.topMargin.equalTo(100)
            make.centerX.equalToSuperview().offset(-30)
        }
        addSubview(tv_network)
        tv_network.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.topMargin.equalTo(100)
            make.centerX.equalToSuperview().offset(30)
        }
        
    }
    
    let iv_circle: UIImageView = {
        var bg = UIImageView()
        bg.image = UIImage(named: "bg_time")
        bg.contentMode = .scaleAspectFill
        return bg
    }()
    
    let tv_hour: UILabel = {
        var tv = UILabel()
        tv.textColor = UIColor.primaryDarkColor()
        tv.font = UIFont.systemFont(ofSize: 60)
        return tv
    }()
    
    let tv_minutes: UILabel = {
        var tv = UILabel()
        tv.textColor = UIColor.primaryDarkColor()
        tv.font = UIFont.systemFont(ofSize: 60)
        return tv
    }()
    
    let tv_date: UILabel = {
        var tv = UILabel()
        tv.textColor = UIColor.primaryDarkColor()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textAlignment = .center
        return tv
    }()
    
    let tv_network: UILabel = {
        var tv = UILabel()
        tv.text = "Conectado a la red "
        return tv
    }()
    
    let iv_network: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "ic_wifi_green")
        return iv
    }()
    
    let tv_message: UILabel = {
        var tv = UILabel()
        tv.text = "message"
        return tv
    }()
    
    let iv_not_wifi: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "ic_wifi_icono")
        return iv
    }()
    
    let btn_assistance: RoundedButton = {
        var btn = RoundedButton()
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.setTitle(title: "XD", color: UIColor.primaryColor())
        return btn
    }()
    
    @objc func login() {
        loginAction?()
    }
    
}
