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
    
    @IBOutlet weak var tv_activity_info: UILabel!
    
    @IBOutlet weak var btn_hour_plus: UIButton!
    @IBOutlet weak var btn_hour_minus: UIButton!
    @IBOutlet weak var tv_hour: UILabel!
    
    @IBOutlet weak var btn_minute_plus: UIButton!
    @IBOutlet weak var tv_minute: UILabel!
    @IBOutlet weak var btn_minute_minus: UIButton!
    
    @IBOutlet weak var iv_kind_of_activity: UIImageView!
    
    var activity: Activity! = nil {
        didSet {
            
            if let kind_of_activity = activity.str_taskname {
                self.tv_kind_of_activity.text = kind_of_activity
            }
            
            if let activity_date = activity.dte_activitydate, let project_code = activity.str_project_cod {
                self.tv_activity_info.text = "\(activity_date) - \(project_code)"
            }
            
            if let hours = activity.num_registered_hours {
                self.tv_hour.text = "\(hours)"
            }
            
            if let minutes = activity.num_registered_minutes {
                self.tv_minute.text = "\(minutes)"
            }
            
        }
    }
    
}
