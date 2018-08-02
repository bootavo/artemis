//
//  ActivitiesController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/6/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyUserDefaults

class RegisterActivityController: UIViewController, UIApplicationDelegate{
    
    var registerActivityView: RegisterActivityView!
    
    var popUpTime: PopUpTime = Util.getVCRef("PopUpTime", nameFile: "Main") as! PopUpTime
    var popUpProject: PopUpProject = Util.getVCRef("PopUpProject", nameFile: "Main") as! PopUpProject
    var popUpKindOfActivity: PopUpKindOfActivity = Util.getVCRef("PopUpKindOfActivity", nameFile: "Main") as! PopUpKindOfActivity
    var popUpMinutes: PopUpMinutes = Util.getVCRef("PopUpMinutes", nameFile: "Main") as! PopUpMinutes
    
    var screen: CGRect? = nil
    var screenWidth: CGFloat? = nil
    var screenHeight: CGFloat? = nil
    
    var hours:Int = 0
    var minutes:Int = 0
    
    var project:Project? = nil
    var kindOfActivity:KindOfActivity? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
        
        //Delegate
        popUpTime.delegate = self
        popUpProject.delegate = self
        popUpKindOfActivity.delegate = self
        popUpMinutes.delegate = self
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
        registerActivityView = RegisterActivityView(frame: self.view.frame)
        self.view.addSubview(registerActivityView)
        registerActivityView.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self.view)
        }
        self.registerActivityView.saveAction = save
        self.registerActivityView.doneAction = done
        
        self.registerActivityView.getProjectsAction = getProjects
        self.registerActivityView.getKindOfActivitiesAction = getKindOfActivities
        
        self.registerActivityView.getHoursAction = gethours
        self.registerActivityView.getMinutesAction = getMinutes
    }
    
    func save(){
        print("save")
        if verify() {
            let code = Defaults[.employee_code]!
            let subParameters = ["str_act_description": "\(self.registerActivityView.tf_description.text!)",
                                 "num_registered_hours":hours,
                                 "num_registered_minutes":minutes,
                                 "str_resource_id":"\(code)",
                                 "num_task_id":kindOfActivity!.num_task_id!,
                                 "str_createdby":12, //Pormientras
                                 "dte_activitydate": self.registerActivityView.tf_date.text!] as [String : Any]
            
            let parameters = ["activity": subParameters] as [String : Any]
            
            ApiService.sharedInstance.registerActivity(parameters: parameters) { (err, statusCode, json) in
                print("before error")
                
                if let error = err {
                    print("Error: \(error)")
                    return
                }
                
                print("statusCode: \(statusCode)")
                if statusCode == 200 {
                    print("registro satisfactorio")
                } else {
                    print("No registro")
                }
            }
        } else {
            self.view.makeToast("Complete todos los campos")
        }
    }
    
    func verify() -> Bool {
        if self.registerActivityView.tf_date.text == "" ||
            self.registerActivityView.tf_project.text == "" ||
                self.registerActivityView.tf_activity.text == "" ||
                    self.registerActivityView.tf_hours.text == "" ||
            self.registerActivityView.tf_minutes.text == "" {
            
            print("true")
            print("""
                Datos para enviar al json:
                cod proy: \(project!.num_project_id!)
                cod kindOfActivity: \(kindOfActivity!.num_task_id!)
                hours: \(hours)
                minutes: \(minutes)
                """)
            
            return false
        }else {
            print("true")
            print("""
                Datos para enviar al json:
                cod proy: \(project!.num_project_id!)
                cod kindOfActivity: \(kindOfActivity!.num_task_id!)
                hours: \(hours)
                minutes: \(minutes)
                """)
            return true
        }
        
    }
    
    func done(){
        print("done")
    }
    
    func getProjects() {
        print("getProjects")
        self.popUpProject.modalPresentationStyle = .overCurrentContext
        self.popUpProject.modalTransitionStyle = .crossDissolve
        self.present(popUpProject, animated: true, completion: nil)
    }
    
    func getKindOfActivities() {
        print("getKindOfActivities")
        self.view.endEditing(true)
        if(project == nil){
            self.view.makeToast("Debe escoger un proyecto")
        }else{
            self.popUpKindOfActivity.modalPresentationStyle = .overCurrentContext
            self.popUpKindOfActivity.modalTransitionStyle = .crossDissolve
            self.popUpKindOfActivity.projectId = self.project!.num_project_id!
            self.present(popUpKindOfActivity, animated: true, completion: nil)
        }
    }
    
    func gethours(){
        print("gethours")
        self.popUpTime.modalPresentationStyle = .overCurrentContext
        self.popUpTime.modalTransitionStyle = .crossDissolve
        self.present(popUpTime, animated: true, completion: nil)
    }
    
    func getMinutes(){
        print("getMinutes")
        self.popUpMinutes.modalPresentationStyle = .overCurrentContext
        self.popUpMinutes.modalTransitionStyle = .crossDissolve
        self.present(popUpMinutes, animated: true, completion: nil)
    }
    
    func getNumberFormat(number: Int, type: String) -> String{
        var timeTag = ""
        if type == "H" {
            timeTag = "h"
        }else{
            timeTag = "min"
        }
        
        var stringNumber = ""
        if number < 10 {
            stringNumber = "0\(number)"
        }else{
            stringNumber = "\(number)"
        }
        return ("\(stringNumber)\(timeTag)")
    }
    
}

extension RegisterActivityController: PopUpTimeDelegate {
    func didSelectItem(item: String) {
        hours = Int(item)!
        self.registerActivityView.tf_hours.text = getNumberFormat(number: hours, type: "H")
    }
}

extension RegisterActivityController: PopUpMinutesDelegate {
    func didSelectMinutes(item: String) {
        minutes = Int(item)!
        self.registerActivityView.tf_minutes.text = getNumberFormat(number: minutes, type: "M")
    }
}

extension RegisterActivityController: PopUpProjectDelegate {
    func didSelectItemProject(item: Project) {
        project = item
        self.registerActivityView.tf_project.text = "\(project!.str_project_name!)"
    }
}

extension RegisterActivityController: PopUpKindOfActivityDelegate {
    func didSelectItemKindOfActivity(item: KindOfActivity) {
        kindOfActivity = item
        self.registerActivityView.tf_activity.text = "\(kindOfActivity!.str_taskname!)"
    }
}
