//
//  TabBarController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TabBarController: UITabBarController {
    
    var viewControllers2:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setupTabBar(){
        //self.view.backgroundColor = UIColor.primaryColor()
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.primaryDarkColor()
        
        /*
        let assistances = UINavigationController(rootViewController: AssistanceController())
        assistances.tabBarItem.image = UIImage(named: "ic_assistance_gray")
        assistances.tabBarItem.selectedImage = UIImage(named: "ic_assistance_red")
        */
        
        let layoutAssistance = UICollectionViewFlowLayout()
        let loginController = AssistanceController(collectionViewLayout: layoutAssistance)
        
        let assistances = UINavigationController(rootViewController: loginController)
        assistances.tabBarItem.image = UIImage(named: "ic_assistance_gray")
        assistances.tabBarItem.selectedImage = UIImage(named: "ic_assistance_red")
        
        let reportLayout = UICollectionViewFlowLayout()
        let reportController = ReportController(collectionViewLayout: reportLayout)
        
        let reports = UINavigationController(rootViewController: reportController)
        reports.tabBarItem.image = UIImage(named: "ic_absent_gray")
        reports.tabBarItem.selectedImage = UIImage(named: "ic_absent_red")
        
        //let activity = Util.getVCRef("Activity", nameFile: "Main") as! ActivityController
        //activity.tabBarItem.image = UIImage(named: "ic_activity_gray")
        //activity.tabBarItem.selectedImage = UIImage(named: "ic_activity_red")
        
        let activityLayout = UICollectionViewFlowLayout()
        let activityController = ActivityController(collectionViewLayout: activityLayout)
        
        let activity2 = UINavigationController(rootViewController: activityController)
        activity2.tabBarItem.image = UIImage(named: "ic_activity_gray")
        activity2.tabBarItem.selectedImage = UIImage(named: "ic_activity_red")
        
        //let projects = UINavigationController(rootViewController: ProjectController())
        //let projects = Util.getVCRef("Project", nameFile: "Main") as! ProjectController
        let projectLayout = UICollectionViewFlowLayout()
        let projectController = ProjectController(collectionViewLayout: projectLayout)
    
        let project2 = UINavigationController(rootViewController: projectController)
        project2.tabBarItem.image = UIImage(named: "ic_project_gray")
        project2.tabBarItem.selectedImage = UIImage(named: "ic_project_red")
        
        //let user = UINavigationController(rootViewController: UserController())
        //user.tabBarItem.image = UIImage(named: "ic_user_gray")
        //user.tabBarItem.selectedImage = UIImage(named: "ic_user_red")
        
        let userLayout = UICollectionViewFlowLayout()
        let userController = UserController(collectionViewLayout: userLayout)
        
        let user = UINavigationController(rootViewController: userController)
        user.tabBarItem.image = UIImage(named: "ic_user_gray")
        user.tabBarItem.selectedImage = UIImage(named: "ic_user_red")
        
        print("Modulo: \(Defaults[.moduleAssistance] ?? "")")
        print("Modulo: \(Defaults[.moduleReport] ?? "")")
        print("Modulo: \(Defaults[.moduleActivity] ?? "")")
        print("Modulo: \(Defaults[.moduleProject] ?? "")")
        print("Modulo: \(Defaults[.moduleUser] ?? "")")
        
        var moduless: [String!] = [Defaults[.moduleAssistance], Defaults[.moduleReport], Defaults[.moduleActivity], Defaults[.moduleProject], Defaults[.moduleUser]]
        let modules:[String] = moduless.map{ $0 ?? "" }
        
        let app_modules: [String] = Constants.APP_MODULES
        print("Modulos Constants: \(Constants.APP_MODULES)")
        
        let moduleTest = ["test"]
        
            for module in modules ?? moduleTest {
                print("entro al segundo if")
                switch module {
                case Constants.MODULE_ASSISTANCE:
                    print("assistances")
                    self.viewControllers2.append(assistances)
                case Constants.MODULE_REPORT:
                    self.viewControllers2.append(reports)
                    print("reports")
                case Constants.MODULE_ACTIVITY:
                    self.viewControllers2.append(activity2)
                    print("activity2")
                case Constants.MODULE_PROJECT:
                    //self.viewControllers2.append(project2)
                    print("project2")
                    
                case Constants.MODULE_USER:
                    self.viewControllers2.append(user)
                    print("user")
                default: break
                }
            }
        
        if !modules.contains(Constants.MODULE_USER) {
            self.viewControllers2.append(user)
        }
        
        viewControllers = viewControllers2
        
        //viewControllers = [assistances, reports, activity2, project2, user]
    }
    
}
