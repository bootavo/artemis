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
        let activityController = ActivityController2(collectionViewLayout: activityLayout)
        
        let activity2 = UINavigationController(rootViewController: activityController)
        activity2.tabBarItem.image = UIImage(named: "ic_activity_gray")
        activity2.tabBarItem.selectedImage = UIImage(named: "ic_activity_red")
        
        //let projects = UINavigationController(rootViewController: ProjectController())
        //let projects = Util.getVCRef("Project", nameFile: "Main") as! ProjectController
        let projectLayout = UICollectionViewFlowLayout()
        let projectController = ProjectController2(collectionViewLayout: projectLayout)
    
        let project2 = UINavigationController(rootViewController: projectController)
        project2.tabBarItem.image = UIImage(named: "ic_project_gray")
        project2.tabBarItem.selectedImage = UIImage(named: "ic_project_red")
        
        let user = UINavigationController(rootViewController: UserController())
        user.tabBarItem.image = UIImage(named: "ic_user_gray")
        user.tabBarItem.selectedImage = UIImage(named: "ic_user_red")
        
        viewControllers = [assistances, reports, activity2, project2, user]
    }
    
}
