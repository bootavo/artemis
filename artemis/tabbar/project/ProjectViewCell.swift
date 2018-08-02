//
//  ProjectViewCell.swift
//  artemis
//
//  Created by VF Consulting on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ProjectViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tv_project_code: UILabel!
    @IBOutlet weak var tv_project_name: UILabel!
    @IBOutlet weak var tv_project_date: UILabel!
    @IBOutlet weak var tv_project_status: UILabel!
    
    @IBOutlet weak var iv_status: UIImageView!
    
    var project: ProjectHelper! = nil {
        didSet {
            
            if let code = project.project_code {
                print("\(code)")
                self.tv_project_code.text = code
            }
            
            if let name = project.project_name {
                print("\(name)")
                self.tv_project_name.text = name
            }
            
            if let date = project.project_date {
                print("\(date)")
                self.tv_project_date.text = date
            }
            
            if let status = project.project_status {
                print("\(status)")
                self.tv_project_status.text = status
                if status == "A"{
                    self.iv_status.image = UIImage(named: "ic_circle_green")
                }else if status == "I" {
                    self.iv_status.image = UIImage(named: "ic_circle_red")
                }
            }
            
        }
    }
    
}
