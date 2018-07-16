//
//  InstanceVCWSB.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class Util: UIViewController {
    
    static func getVCRef(_ viewControllerName: String, nameFile: String)->UIViewController{
        let storyB: UIStoryboard = UIStoryboard(name: nameFile, bundle: nil)
        let vc = storyB.instantiateViewController(withIdentifier: viewControllerName)
        return vc
    }
    
    static func getVCRef(nameFile: String)->UIViewController{
        let storyB: UIStoryboard = UIStoryboard(name: nameFile, bundle: nil)
        let vc = storyB.instantiateInitialViewController()
        return vc!
    }
    
}
