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
import PopupDialog
import MessageUI

var user: User = User()

class UserController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, MFMailComposeViewControllerDelegate {
    
    var categoryProjects: [CategoryProjects]?
    var listProjects: [Project]?
    
    let cellId = "cellId"
    let cellId2 = "cellId2"
    
    var viewCustom:UIView?
    
    private let refreshControl = UIRefreshControl()
    
    //public let heighOfNavigationBar: CGFloat = 60
    //public let heightOfCells: CGFloat = 55
    //public let separationBetweenCells: CGFloat = 0 //30
    
    
    //Dialog objects
    // Prepare the popup assets
    let titlePopUp = "ARTEMIS"
    let messagePopUp = """
                        Para cualquier bug o sugerencia hacia la aplicacion, enviar su screenshot y mensaje a:
                        artemis.app.support@vfcons.com
                        """
    let imagePopUp = UIImage(named: "appIcon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCustom = self.view
        
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
        
        print(categoryProjects)
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
        if let xd = categoryProjects?[0], let xd2 = categoryProjects?[1] {
            print("---count caegories: \(categoryProjects!.count)")
            //print("---count project 1: \(categoryProjects![0].projects?.count)")
            //print("---count project 2: \(categoryProjects![1].projects?.count)")
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
        
        var heighCollecitonView:CGFloat = 0
        
        if ScreenHelper.init().getDevice() == Constants.DEVICE_SMARTPHONE {
            heighCollecitonView = 160
        }else {
            heighCollecitonView = 190
        }
        
        return CGSize(width: view.frame.width, height: heighCollecitonView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func setupViews(){
        
        self.view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.leftMargin.equalTo(0)
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
            make.top.bottom.equalTo(fullNameLabel).offset(30)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        
        self.view.addSubview(btnEndSession)
        btnEndSession.snp.makeConstraints{ (make) in
            make.top.bottom.equalTo(rolLabel).offset(20)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 200, height: 80))
        }
        
        self.view.addSubview(inprogress_message)
        inprogress_message.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        self.view.addSubview(done_message)
        done_message.snp.makeConstraints{ (make) in
            if ScreenHelper.init().getDevice() == Constants.DEVICE_SMARTPHONE {
                make.top.equalToSuperview().offset(360)
            }else {
                make.top.equalToSuperview().offset(390)
            }
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        self.view.addSubview(v_separator)
        v_separator.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            
            if ScreenHelper.init().getDevice() == Constants.DEVICE_SMARTPHONE {
                make.top.equalToSuperview().offset(480)
            }else{
                make.top.equalToSuperview().offset(520)
            }
            
            make.width.equalToSuperview().inset(32)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(btnHelp)
        btnHelp.snp.makeConstraints{ (make) in
            
            if ScreenHelper.init().getDevice() == Constants.DEVICE_SMARTPHONE {
                make.top.equalToSuperview().offset(495)
            }else {
                make.top.equalToSuperview().offset(530)
            }
            
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 40))
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
    
    let btnEndSession: UIButton = {
        let button = UIButton()
        button.setTitle(title: "Cerrar sesión", color: UIColor.title())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(endSession), for: .touchUpInside)
        return button
    }()
    
    let done_message: UILabel = {
        let label = UILabel()
        label.text = "Cargando..."
        label.textColor = UIColor.subTitleList()
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        label.numberOfLines = 2
        label.textAlignment = .center
        return label;
    }()
    
    let inprogress_message: UILabel = {
        let label = UILabel()
        label.text = "Cargando..."
        label.textColor = UIColor.subTitleList()
        label.font = UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        label.numberOfLines = 2
        label.textAlignment = .center
        return label;
    }()
    
    let v_separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let btnHelp: RoundedButton = {
        let button = RoundedButton()
        button.setTitle(title: "Ayuda y Sugerencias", color: UIColor.white)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(help), for: .touchUpInside)
        return button
    }()
    
    @objc func help() {
//        let popup = PopupDialog(title: self.titlePopUp, message: self.messagePopUp, image: imagePopUp)
//        popup.addButtons([buttonOne, buttonTwo])
//        self.present(popup, animated: true, completion: nil)
        
        let alert = UIAlertController(title: titlePopUp, message: messagePopUp, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Enciar correo", style: .default, handler: { action in
            print("Yay! You brought your towel!")
            self.sendEmail()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func endSession() {
        Defaults.removeAll()
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        let vc = LoginController()
        UIApplication.shared.beginIgnoringInteractionEvents()
        Timer.after(1.second) {
            UIViewController.removeSpinner(spinner: sv)
            exit(0)
//            self.present(vc, animated: true, completion: nil)
//            UIApplication.shared.endIgnoringInteractionEvents()

        }
    }
    
    // Create buttons
    let buttonOne = CancelButton(title: "ATRAS") {
        print("You canceled the car dialog.")
    }
    
    // This button will not the dismiss the dialog
    let buttonTwo = DefaultButton(title: "ENVIAR EMAIL", height: 60, dismissOnTap: true) {
        
    }
    
    func sendEmail(){
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setToRecipients(["artemis.app.support@vfcons.com"])
        picker.setSubject("Sugerencias / Bug")
        present(picker, animated: true, completion: nil)
    }
    
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
                            
                            var projectsDone : [Project] = []
                            var projectsInProgress : [Project] = []
                            
                            
                            if self.listProjects! != nil {
                                for project in self.listProjects! {
                                    if project.str_project_status != nil {
                                        if (project.str_project_status! == "In Progress"){
                                            projectsDone.append(project)
                                        } else if (project.str_project_status! == "Done") {
                                            projectsInProgress.append(project)
                                        }
                                        projectsDone.append(project)
                                        projectsInProgress.append(project)
                                    }
                                }
                                
                                self.categoryProjects![0].projects = projectsInProgress as? [Project]
                                
                                self.categoryProjects![1].projects = projectsDone as? [Project]
                            }
                            
                            if projectsDone.isEmpty {
                                self.done_message.isHidden = false
                                self.done_message.text = "No cuenta con proyectos realizados"
                            }else {
                                self.done_message.isHidden = true
                            }
                            
                            if projectsInProgress.isEmpty {
                                self.inprogress_message.isHidden = false
                                self.inprogress_message.text = "No cuenta con proyectos en curso"
                            }else {
                                self.inprogress_message.isHidden = true
                            }
                            
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
                    //self.view.makeToast("No se ha podido cargar los lugares de trabajo")
                    self.done_message.text = "No cuenta con proyectos realizados"
                    self.inprogress_message.text = "No cuenta con proyectos en curso"
                }
            }
        }
        
    }
    
}
