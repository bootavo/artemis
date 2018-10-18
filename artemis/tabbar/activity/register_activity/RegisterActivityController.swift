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
import PopupDialog

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
        getProjectsA()
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
                
                if let error = err {
                    print("Error: \(error)")
                    return
                }
                
                print("statusCode: \(statusCode)")
                if statusCode == 200 {
                    print("registro satisfactorio")
                    self.dismiss(animated: true, completion: nil)
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    self.view.makeToast("Registro satisfactorio")
                } else {
                    print("No registro")
                    self.view.makeToast("Registro satisfactorio")
                }
            }
        }
    }
    
    func verify() -> Bool {
        if self.registerActivityView.tf_date.text == "" ||
            self.registerActivityView.tf_project.text == "" ||
                self.registerActivityView.tf_activity.text == "" ||
                    self.registerActivityView.tf_hours.text == "" ||
            self.registerActivityView.tf_minutes.text == "" {
            
//            print("true")
//            print("""
//                Datos para enviar al json:
//                cod proy: \(project!.num_project_id!)
//                cod kindOfActivity: \(kindOfActivity!.num_task_id!)
//                hours: \(hours)
//                minutes: \(minutes)
//                """)
            self.view.makeToast("Complete todos los campos")
            return false
        }else {
            print("true")
//            print("""
//                Datos para enviar al json:
//                cod proy: \(project!.num_project_id!)
//                cod kindOfActivity: \(kindOfActivity!.num_task_id!)
//                hours: \(hours)
//                minutes: \(minutes)
//                """)
            
            if hours == 0 && minutes == 0{
                self.view.makeToast("La actividad debe ser 05 min como mínimo")
                return false
            }
            
            return true
        }
        
    }
    
    func done(){
        print("done")
        self.navigationController?.popToRootViewController(animated: true)
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
    
    func getProjectsA(){
        
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
                print("Content: \(content)")
                
                if !content.isEmpty {
                    do {
                        print("attributes")
                        
                        let attributes = content["project_teams"]
                        if !attributes.isEmpty {
                            print("Activities: \(attributes)")
                            let data = try JSONDecoder().decode([Project].self, from: attributes.rawData())
                            Constants.PROJECTS = data
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
    
    func getKindOfActivtyA(){
        let parameters = ["num_project_id": project?.num_project_id] as [String : Any]
        
        ApiService.sharedInstance.getKindOfActivities(parameters: parameters) { (err, statusCode, json) in
            print("before error")
            
            if let error = err {
                print("Error: \(error)")
                return
            }
            
            print("statusCode: \(statusCode)")
            if let json = json {
                let content = json["content"]
                print("Content: \(content)")
                
                if !content.isEmpty {
                    do {
                        print("attributes")
                        
                        let attributes = content["tasks"]
                        if !attributes.isEmpty {
                            print("Tasks: \(attributes)")
                            let data = try JSONDecoder().decode([KindOfActivity].self, from: attributes.rawData())
                            Constants.TASKS = data
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
        print("didSelectItemProject")
        project = item
        self.registerActivityView.tf_project.text = "\(project!.str_project_name!)"
        self.getKindOfActivtyA()
    }
}

extension RegisterActivityController: PopUpKindOfActivityDelegate {
    func didSelectItemKindOfActivity(item: KindOfActivity) {
        kindOfActivity = item
        self.registerActivityView.tf_activity.text = "\(kindOfActivity!.str_taskname!)"
    }
}
