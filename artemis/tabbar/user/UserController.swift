//
//  UserController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyUserDefaults
//import SDWebImage
import SwiftyTimer
import Toast

class UserController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    public let heighOfNavigationBar: CGFloat = 60
    public let heightOfCells: CGFloat = 55
    public let separationBetweenCells: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Title Status Bar White
        UIApplication.shared.statusBarStyle = .lightContent //.lightContent
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Usuario"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.title()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
    }
    
    func setupView(){
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 650)
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            //make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(0)
            make.leftMargin.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        scrollView.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(profileImageView).offset(0)
            make.left.equalTo(profileImageView.snp.right).offset(20)
            //make.right.lessThanOrEqualTo(20)
        }
        
        scrollView.addSubview(rolLabel)
        rolLabel.snp.makeConstraints { (make) in
            //make.top.bottom.equalTo(profileImageView)
            //make.left.equalTo(profileImageView.snp.right).offset(20)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(10)
            //make.top.equalTo(fullNameLabel.snp.bottom).offset(10)
            //make.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(miPerfilCell)
        miPerfilCell.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(miSuscripcionCell)
        miSuscripcionCell.snp.makeConstraints { (make) in
            make.top.equalTo(miPerfilCell.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(compartirCell)
        compartirCell.snp.makeConstraints { (make) in
            make.top.equalTo(miSuscripcionCell.snp.bottom).offset(separationBetweenCells)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(terminosCell)
        terminosCell.snp.makeConstraints { (make) in
            make.top.equalTo(compartirCell.snp.bottom).offset(separationBetweenCells)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(cambiarContrasenaCell)
        cambiarContrasenaCell.snp.makeConstraints { (make) in
            make.top.equalTo(terminosCell.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(acercaCell)
        acercaCell.snp.makeConstraints { (make) in
            make.top.equalTo(cambiarContrasenaCell.snp.bottom).offset(separationBetweenCells)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.scroll()
        return view
    }()

    lazy var profileImageView: ProfileImageView = {
        let imgView = ProfileImageView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgView.addGestureRecognizer(tap)
        imgView.isUserInteractionEnabled = true
        return imgView
    }()

    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Gustavo Tufinho Fernandez"
        label.textColor = UIColor.title()
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    let rolLabel: UILabel = {
        let label = UILabel()
        label.text = "Desarrollador"
        label.textColor = UIColor.subTitleList()
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    lazy var miPerfilCell: MiCuentaCell = {
        let view = MiCuentaCell()
        view.addTarget(self, action: #selector(miCuentaTapped), for: UIControlEvents.touchUpInside)
        view.type = MiCuentaCell.TypeOfCell.first
        return view
    }()
    
    lazy var miSuscripcionCell: MiCuentaCell = {
        let view = MiCuentaCell()
        view.addTarget(self, action: #selector(miSuscripcionTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "Mi suscripción"
        view.type = MiCuentaCell.TypeOfCell.last
        return view
    }()
    
    lazy var compartirCell: MiCuentaCell = {
        let view = MiCuentaCell()
        view.addTarget(self, action: #selector(compartirTapped(_ :)), for: UIControlEvents.touchUpInside)
        view.title.text = "Compartir la aplicación"
        view.type = MiCuentaCell.TypeOfCell.alone
        return view
    }()
    
    lazy var terminosCell: MiCuentaCell = {
        let view = MiCuentaCell()
        view.addTarget(self, action: #selector(terminosTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "Términos y condiciones"
        view.type = MiCuentaCell.TypeOfCell.first
        return view
    }()
    
    lazy var cambiarContrasenaCell: MiCuentaCell = {
        let view = MiCuentaCell()
        view.addTarget(self, action: #selector(cambiarContrasenaTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "Cambiar contraseña"
        view.type = MiCuentaCell.TypeOfCell.last
        return view
    }()
    
    lazy var acercaCell: MiCuentaCell = {
        let view = MiCuentaCell()
        view.addTarget(self, action: #selector(acercaTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "Acerca de Midoc"
        view.type = MiCuentaCell.TypeOfCell.alone
        return view
    }()
    
    @objc private func imageTapped() {
        print("imageTapped")
    }

    @objc func miCuentaTapped() {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("miCuentaTapped()")
    }
    
    @objc func miSuscripcionTapped() {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("miSuscripcionTapped()")
    }
    
    @objc func compartirTapped() {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("compartirTapped()")
    }
    
    @objc func terminosTapped() {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("terminosTapped()")
    }
    
    @objc func compartirTapped(_ sender: UIButton) {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("compartirTapped()")
    }
    
    @objc func cambiarContrasenaTapped() {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("cambiarContrasenaTapped()")
    }
    
    @objc func acercaTapped() {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("acercaTapped()")
    }
    
}
