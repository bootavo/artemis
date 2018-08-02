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
    var str_resource_type:String?
    var num_project_status:Int?
    var str_resource_id:String?
    var str_resource_rol:String?
    var num_prjteam_id:Int?
    var str_project_cod:String?
    var dte_end_date:String?
    var str_resource_name:String?
    var str_project_status:String?
    
    private enum CodingKeys: String, CodingKey {
        case dte_initial_date = "dte_initial_date"
        case num_project_id = "num_project_id"
        case str_project_name = "str_project_name"
        case str_resource_type = "str_resource_type"
        case num_project_status = "num_project_status"
        case str_resource_id = "str_resource_id"
        case str_resource_rol = "str_resource_rol"
        case num_prjteam_id = "num_prjteam_id"
        case str_project_cod = "str_project_cod"
        case dte_end_date = "dte_end_date"
        case str_resource_name = "str_resource_name"
        case str_project_status = "str_project_status"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dte_initial_date = try container.decode(String?.self, forKey: .dte_initial_date)
        num_project_id = try container.decode(Int?.self, forKey: .num_project_id)
        str_project_name = try container.decode(String?.self, forKey: .str_project_name)
        str_resource_type = try container.decode(String?.self, forKey: .str_resource_type)
        num_project_status = try container.decode(Int?.self, forKey: .num_project_status)
        str_resource_id = try container.decode(String?.self, forKey: .str_resource_id)
        str_resource_rol = try container.decode(String?.self, forKey: .str_resource_rol)
        num_prjteam_id = try container.decode(Int?.self, forKey: .num_prjteam_id)
        str_project_cod = try container.decode(String?.self, forKey: .str_project_cod)
        dte_end_date = try container.decode(String?.self, forKey: .dte_end_date)
        str_resource_name = try container.decode(String?.self, forKey: .str_resource_name)
        str_project_status = try container.decode(String?.self, forKey: .str_project_status)
    }
    
}

class ProjectHelper:NSObject {
    
    var id:Int?
    var project_code:String?
    var project_name:String?
    var project_status:String?
    var project_date:String?
    
}



