//
//  Project.swift
//  artemis
//
//  Created by VF Consulting on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class Project:Decodable {
    
    var dte_initial_date:String?
    var num_project_id:Int?
    var str_project_name:String?
    var num_project_status:Int?
    var str_project_cod:String?
    var dte_end_date:String?
    
    private enum CodingKeys: String, CodingKey {
        case dte_initial_date = "dte_initial_date"
        case num_project_id = "num_project_id"
        case str_project_name = "str_project_name"
        case num_project_status = "num_project_status"
        case str_project_cod = "str_project_cod"
        case dte_end_date = "dte_end_date"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dte_initial_date = try container.decode(String?.self, forKey: .dte_initial_date)
        num_project_id = try container.decode(Int?.self, forKey: .num_project_id)
        str_project_name = try container.decode(String?.self, forKey: .str_project_name)
        num_project_status = try container.decode(Int?.self, forKey: .num_project_status)
        str_project_cod = try container.decode(String?.self, forKey: .str_project_cod)
        dte_end_date = try container.decode(String?.self, forKey: .dte_end_date)
    }
    
}

class ProjectHelper:NSObject {
    
    var id:Int?
    var project_code:String?
    var project_name:String?
    var project_status:String?
    var project_date:String?
    
}



