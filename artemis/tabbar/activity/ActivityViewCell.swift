//
//  ActivityViewCell.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ActivityViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tv_kind_of_activity: UILabel!
    @IBOutlet weak var tv_project: UILabel!
    
    @IBOutlet weak var tv_hours_minutes: UILabel!
    @IBOutlet weak var tv_date: UILabel!
    
    @IBOutlet weak var iv_kind_of_activity: UIImageView!
    
    var activity: Task! = nil {
        didSet {
            if let kind_of_activity = activity.str_taskname {
                self.tv_kind_of_activity.text = kind_of_activity.uppercased()
            }
            
            if let project_code = activity.str_project_cod {
                self.tv_project.text = "\(project_code.uppercased())"
            }
            
            tv_hours_minutes.textColor = UIColor.primaryDarkColor()
            if let hours = activity.num_registered_hours, let minutes = activity.num_registered_minutes {
                self.tv_hours_minutes.text = "\(hours)h \(minutes)min"
            }
            
            if let activity_date = activity.dte_activitydate {
                self.tv_date.text = activity_date
            }
        }
    }
    
}
