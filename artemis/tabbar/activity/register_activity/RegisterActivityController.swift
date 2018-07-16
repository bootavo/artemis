//
//  ActivitiesController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/6/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit

class RegisterActivityController: UIViewController, UIApplicationDelegate{
    
    var activityView: RegisterActivityView!
    
    var popUpTime: PopUpTime = Util.getVCRef("PopUpTime", nameFile: "Main") as! PopUpTime
    
     var popUpProject: PopUpProject = Util.getVCRef("PopUpProject", nameFile: "Main") as! PopUpProject
    
    var window2:UIWindow?
    
    var screen: CGRect? = nil
    var screenWidth: CGFloat? = nil
    var screenHeight: CGFloat? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
        
        //Delegate
        popUpTime.delegate = self
        popUpProject.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Actividades"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
        
    }
    
    func setupView(){
        activityView = RegisterActivityView(frame: self.view.frame)
        self.view.addSubview(activityView)
        activityView.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self.view)
        }
        self.activityView.saveAction = save
        self.activityView.doneAction = done
    }
    
    func save(){
        print("save")
        self.popUpProject.modalPresentationStyle = .overCurrentContext
        self.popUpProject.modalTransitionStyle = .crossDissolve
        self.present(popUpProject, animated: true, completion: nil)
    }
    
    func done(){
        print("done")
        self.popUpTime.modalPresentationStyle = .overCurrentContext
        self.popUpTime.modalTransitionStyle = .crossDissolve
        self.present(popUpTime, animated: true, completion: nil)
    }
    
}

extension RegisterActivityController: PopUpTimeDelegate {
    func didSelectItem(item: String) {
        print("escogio el item",item)
    }
}

extension RegisterActivityController: PopUpProjectDelegate {
    func didSelectItemProject(item: String) {
        print("escogio el item",item)
    }
    
}
