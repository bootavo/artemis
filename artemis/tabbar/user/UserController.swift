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
import SDWebImage
import SwiftyTimer
import Toast

var user: User = User()

class UserController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    public let heighOfNavigationBar: CGFloat = 60
    public let heightOfCells: CGFloat = 55
    public let separationBetweenCells: CGFloat = 0 //30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.primaryColor()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Usuario"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
        setupView()
        setupUserInfo()
    }
    
    func setupUserInfo(){
        fullNameLabel.text = "\(Defaults[.name]!)"
        rolLabel.text = "\(Defaults[.name]!)"
        print("\(Defaults[.foto]!)")
        profileImageView.imageView.sd_setImage(with: URL(string: "\(Defaults[.foto]!)"), completed: nil)
    }
    
    func setupView(){
        //self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.primaryColor()
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.width.equalToSuperview()
            make.size.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.leftMargin.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        scrollView.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(profileImageView).offset(0)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        
        scrollView.addSubview(rolLabel)
        rolLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(fullNameLabel).offset(15)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        
        scrollView.addSubview(projectsCell)
        projectsCell.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(quantityProjects)
        quantityProjects.snp.makeConstraints { (make) in
            make.top.equalTo(projectsCell.snp.bottom).offset(separationBetweenCells)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(finishedProjects)
        finishedProjects.snp.makeConstraints { (make) in
            make.top.equalTo(quantityProjects.snp.bottom).offset(separationBetweenCells)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(proy1)
        proy1.snp.makeConstraints { (make) in
            make.top.equalTo(finishedProjects.snp.bottom).offset(separationBetweenCells)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(proy2)
        proy2.snp.makeConstraints { (make) in
            make.top.equalTo(proy1.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(blankSpace)
        blankSpace.snp.makeConstraints { (make) in
            make.top.equalTo(proy2.snp.bottom).offset(separationBetweenCells)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(heightOfCells)
        }
        
        scrollView.addSubview(endSession)
        endSession.snp.makeConstraints { (make) in
            make.top.equalTo(blankSpace.snp.bottom).offset(separationBetweenCells)
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
    
    let detailTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.isHidden = true
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.title()
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        return label
    }()
    
    let rolLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.subTitleList()
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    lazy var projectsCell: MyAccountCell = {
        let view = MyAccountCell()
        view.addTarget(self, action: #selector(miCuentaTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "PROYECTOS EN CURSO"
        view.type = MyAccountCell.TypeOfCell.first
        view.backgroundColor = UIColor.scroll()
        view.detailImageView.isHidden = true
        return view
    }()
    
    lazy var quantityProjects: MyAccountCell = {
        let view = MyAccountCell()
        view.addTarget(self, action: #selector(miCuentaTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "3 Proyectos"
        view.type = MyAccountCell.TypeOfCell.between
        return view
    }()
    
    lazy var finishedProjects: MyAccountCell = {
        let view = MyAccountCell()
        view.addTarget(self, action: #selector(miCuentaTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "PROYECTOS FINALIZADOS"
        view.type = MyAccountCell.TypeOfCell.between
        view.backgroundColor = UIColor.scroll()
        view.detailImageView.isHidden = true
        return view
    }()
    
    lazy var proy1: MyAccountCell = {
        let view = MyAccountCell()
        view.addTarget(self, action: #selector(terminosTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "PRY-072-NOMBREPROYECTO"
        view.type = MyAccountCell.TypeOfCell.between
        return view
    }()
    
    lazy var proy2: MyAccountCell = {
        let view = MyAccountCell()
        view.addTarget(self, action: #selector(cambiarContrasenaTapped), for: UIControlEvents.touchUpInside)
        view.title.text = "PRY-072-NOMBREPROYECTO"
        view.type = MyAccountCell.TypeOfCell.between
        return view
    }()
    
    lazy var blankSpace: MyAccountCell = {
        let view = MyAccountCell()
        view.addTarget(self, action: #selector(miCuentaTapped), for: UIControlEvents.touchUpInside)
        view.title.text = ""
        view.type = MyAccountCell.TypeOfCell.between
        view.backgroundColor = UIColor.scroll()
        view.detailImageView.isHidden = true
        return view
    }()
    
    lazy var endSession: MyAccountCellRed = {
        let view = MyAccountCellRed()
        view.addTarget(self, action: #selector(closeSession), for: UIControlEvents.touchUpInside)
        view.title.text = "Cerrar Sesion"
        view.type = MyAccountCellRed.TypeOfCell.alone
        view.backgroundColor = UIColor.primaryDarkColor()
        view.title.textColor = UIColor.primaryColor()
        //view.backgroundColor = view.isHighlighted ? UIColor.primaryDarkColor() : UIColor.primaryDarkColor()
        //view.backgroundColor = view.isSelected ? UIColor.primaryDarkColor() : UIColor.primaryDarkColor()
        view.detailImageView.isHidden = true
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
    
    @objc func closeSession() {
        //let vc = MiPerfilViewController()
        //self.present(vc, animated: true, completion: nil)
        print("endSession()")
    }
    
}
