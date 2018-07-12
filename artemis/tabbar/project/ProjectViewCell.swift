//
//  ProjectViewCell.swift
//  artemis
//
//  Created by VF Consulting on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class BasesCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}

class ProjectViewCell: BasesCell {
    
    @IBOutlet weak var tv_project_code: UILabel!
    @IBOutlet weak var tv_project_name: UILabel!
    @IBOutlet weak var tv_project_date: UILabel!
    @IBOutlet weak var tv_project_status: UILabel!
    
    @IBOutlet weak var iv_status: UIImageView!
    
    var project:Project? {
        didSet {
            
            self.tv_project_code.text = project?.project_code
            self.tv_project_name.text = project?.project_name
            self.tv_project_date.text = project?.project_date
            
            if let status = project?.project_status {
                if status == "A"{
                    self.iv_status.image = UIImage(named: "ic_circle_green")
                }else if status == "I" {
                    self.iv_status.image = UIImage(named: "ic_circle_red")
                }
            }
            
        }
    }
    
}
