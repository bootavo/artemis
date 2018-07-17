//
//  TabBarController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar(){
        self.view.backgroundColor = UIColor.primaryColor()
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = UIColor.primaryDarkColor()
        
        let assistances = UINavigationController(rootViewController: AssistanceController())
        assistances.tabBarItem.image = UIImage(named: "ic_assistance_gray")
        assistances.tabBarItem.selectedImage = UIImage(named: "ic_assistance_red")
        
        let absents = Util.getVCRef("KindOfReport", nameFile: "Main") as! AbsentController
        absents.tabBarItem.image = UIImage(named: "ic_absent_gray")
        absents.tabBarItem.selectedImage = UIImage(named: "ic_absent_red")
        
        //let activity = UINavigationController(rootViewController: RegisterActivityController())
        let activity = Util.getVCRef("Activity", nameFile: "Main") as! ActivityController
        activity.tabBarItem.image = UIImage(named: "ic_activity_gray")
        activity.tabBarItem.selectedImage = UIImage(named: "ic_activity_red")
        
        //let projects = UINavigationController(rootViewController: ProjectController())
        let projects = Util.getVCRef("Project", nameFile: "Main") as! ProjectController
        projects.tabBarItem.image = UIImage(named: "ic_project_gray")
        projects.tabBarItem.selectedImage = UIImage(named: "ic_project_red")
        
        let user = UINavigationController(rootViewController: UserController())
        user.tabBarItem.image = UIImage(named: "ic_user_gray")
        user.tabBarItem.selectedImage = UIImage(named: "ic_user_red")
        
        viewControllers = [assistances, absents, activity, projects, user]
    }
    
}
