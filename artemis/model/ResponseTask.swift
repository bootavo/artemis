//
//  ResponseActivity.swift
//  artemis
//
//  Created by VF Consulting on 7/30/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation

class ResponseTask: NSObject, Decodable {
    var status: Int?
    var content: [Task]?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case content = "content"
        case message = "activities"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int?.self, forKey: .status)
        content = try container.decode([Task]?.self, forKey: .content)
        message = try container.decode(String?.self, forKey: .message)
    }
    
}

class Task:Decodable {
    
    var str_taskname:String?
    var num_registered_minutes:Int?
    var str_act_description:String?
    var num_registered_hours:Int?
    var str_project_name:String?
    var dte_activitydate:String?
    var str_project_cod:String?
    var num_activity_id:Int?
    var num_task_id:Int?
    
    private enum CodingKeys: String, CodingKey {
        case str_taskname = "str_taskname"
        case num_registered_minutes = "num_registered_minutes"
        case str_act_description = "str_act_description"
        case num_registered_hours = "num_registered_hours"
        case str_project_name = "str_project_name"
        case dte_activitydate = "dte_activitydate"
        case str_project_cod = "str_project_cod"
        case num_activity_id = "num_activity_id"
        case num_task_id = "num_task_id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        str_taskname = try container.decode(String?.self, forKey: .str_taskname)
        num_registered_minutes = try container.decode(Int?.self, forKey: .num_registered_minutes)
        str_act_description = try container.decode(String?.self, forKey: .str_act_description)
        num_registered_hours = try container.decode(Int?.self, forKey: .num_registered_hours)
        str_project_name = try container.decode(String?.self, forKey: .str_project_name)
        dte_activitydate = try container.decode(String?.self, forKey: .dte_activitydate)
        str_project_cod = try container.decode(String?.self, forKey: .str_project_cod)
        num_activity_id = try container.decode(Int?.self, forKey: .num_activity_id)
        num_task_id = try container.decode(Int?.self, forKey: .num_task_id)
    }
    
}


