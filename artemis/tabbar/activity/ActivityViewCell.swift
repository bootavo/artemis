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
            
            if let kind_of_activity = activity.kind_of_activity {
                self.tv_kind_of_activity.text = kind_of_activity
            }
            
            if let activity_date = activity.date, let project_code = activity.project_code {
                self.tv_activity_info.text = "\(activity_date) - \(project_code)"
            }
            
            if let hours = activity.activity_hours {
                self.tv_hour.text = hours
            }
            
            if let minutes = activity.activity_minutes {
                self.tv_minute.text = minutes
            }
            
        }
    }
    
}
