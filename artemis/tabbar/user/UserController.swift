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

class UserController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate {
    
    var categoryProjects: [CategoryProjects]?
    var listProjects: [Project]?
    
    let cellId = "cellId"
    let cellId2 = "cellId2"
    
    private let refreshControl = UIRefreshControl()
    
    //public let heighOfNavigationBar: CGFloat = 60
    //public let heightOfCells: CGFloat = 55
    //public let separationBetweenCells: CGFloat = 0 //30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("------------------------------> UserController <------------------------------")
        setCategoryProjects()
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(ProjectStatusCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ProjectStatusCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(140, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.alwaysBounceVertical = false
        collectionView?.bounces = false
        //collectionView?.flashScrollIndicators()
        
        setupViews()
        setupUserInfo()
        
        getService()
        
    }
    
    func setCategoryProjects(){
        print("--------- > setCategoryProjects()")
        //build project data
        let categoryDoing = CategoryProjects()
        categoryDoing.category_name = "PROYECTOS EN CURSO"
        
        let categoryDone = CategoryProjects()
        categoryDone.category_name = "PROYECTOS FINALIZADOS"
        
        self.categoryProjects = [categoryDoing, categoryDone]
        
        print("--------- > /setCategoryProjects()")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        //self.navigationController?.navigationBar.isTranslucent = false // need specificate when general trnasulcent is false
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Usuario"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProjectStatusCell
        //cell.categoryProjects = categoryProjects?[indexPath.item]
        
        print("----------> cellForItemAt()")
        if let xd = categoryProjects?[0].projects?[0], let xd2 = categoryProjects?[1].projects?[0] {
            print("---count caegories: \(categoryProjects!.count)")
            print("---count project 1: \(categoryProjects![0].projects?.count)")
            print("---count project 2: \(categoryProjects![1].projects?.count)")
            cell.categoryProjects = categoryProjects?[indexPath.item]
        }
        print("----------> /cellForItemAt()")
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("----------> numberOfItemSection()")
        print("---count caegories: \(categoryProjects!.count)")
        print("---count project 1: \(categoryProjects![0].projects?.count)")
        print("---count project 2: \(categoryProjects![1].projects?.count)")
        print("----------> /numberOfItemSection()")
        return categoryProjects!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func setupViews(){
        self.view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.leftMargin.equalTo(20)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        self.view.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(profileImageView).offset(0)
            make.left.equalTo(profileImageView.snp.right).offset(20)
            make.size.equalTo(CGSize(width: 200, height: 80))
        }
        
        self.view.addSubview(rolLabel)
        rolLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(fullNameLabel).offset(30).constraint
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
    }
    
    func setupUserInfo(){
        
        fullNameLabel.text = "\(Defaults[.name]!) \(Defaults[.patternLastName]!) \(Defaults[.matternLastName]!) "
        rolLabel.text = "\(Defaults[.employee_code]!)"
        profileImageView.imageView.sd_setImage(with: URL(string: "\(Defaults[.foto]!)"), completed: nil)
        
        //scrollView.alwaysBounceVertical = true
        
    }
    
    lazy var profileImageView: ProfileImageView = {
        let imgView = ProfileImageView()
        //let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        //imgView.addGestureRecognizer(tap)
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
        label.numberOfLines = 2
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
    
    func getService() {
        
        let code = Defaults[.employee_code]
        let parameters = ["str_resource_id": code!] as [String : Any]
        
        ApiService.sharedInstance.getProjectsByResourceId(parameters: parameters) { (err, statusCode, json) in
            print("before error")
            
            if let error = err {
                print("Error: \(error)")
                return
            }
            
            print("statusCode: \(statusCode)")
            if let json = json {
                let content = json["content"]
                //print("Content: \(content)")
                
                if !content.isEmpty {
                    do {
                        
                        let attributes = content["project_teams"]
                        if !attributes.isEmpty {
                            print("Activities: \(attributes)")
                            self.listProjects = try JSONDecoder().decode([Project].self, from: attributes.rawData())
                            
                            let project = self.listProjects?[0]
                            
                            //self.categoryProjects![0].projects = try JSONDecoder().decode([Project].self, from: attributes.rawData())
                            
                            self.categoryProjects![0].projects = [project,project,project,project,project,project] as! [Project]
                            
                            //self.categoryProjects![1].projects = try JSONDecoder().decode([Project].self, from: attributes.rawData())
                            
                            self.categoryProjects![1].projects = [project,project,project,project,project,project] as! [Project]
                            
                            print("reload")
                            self.collectionView?.reloadData()
                        }else {
                            print("Actividades vacias")
                        }
                    }catch let error {
                        print("no se pudo decodificar",error)
                        self.view.makeToast("Datos incorrectos")
                    }
                } else {
                    print("Contenido vacio")
                    self.view.makeToast("No se ha podido cargar los lugares de trabajo")
                }
            }
        }
        
    }
    
}
