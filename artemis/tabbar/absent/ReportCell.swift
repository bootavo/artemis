//
//  ReportCell.swift
//  artemis
///Users/vfcons/Documents/XcodeProjects/artemis/artemis/tabbar/absent/ReportCell.swift
//  Created by VF Consulting on 7/16/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ReportCell: UICollectionViewCell {
    
    @IBOutlet weak var iv_icon: UIImageView!
    @IBOutlet weak var tv_title: UILabel!
    @IBOutlet weak var tv_description: UILabel!
    
    var kind_of_report: KindOfReport! = nil {
        didSet {
            
            if let title = kind_of_report.title {
                self.tv_title.text = title
            }
            
            if let description = kind_of_report.desc {
                self.tv_description.text = description
            }
            
            if let photo = kind_of_report.photo {
                self.iv_icon.image = UIImage(named: "\(photo)")
            }
            
        }
    }
    
}
