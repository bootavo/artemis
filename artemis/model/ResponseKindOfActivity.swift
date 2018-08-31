//
//  ResponseKindOfActivity.swift
//  artemis
//
//  Created by VF Consulting on 7/31/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation

class ResponseKindOfActivity: Decodable {
    var status: Int?
    var content: [KindOfActivity]?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case content = "content"
        case message = "activities"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int?.self, forKey: .status)
        content = try container.decode([KindOfActivity]?.self, forKey: .content)
        message = try container.decode(String?.self, forKey: .message)
    }
    
}

class KindOfActivity:Decodable {
    
    var str_project_name:String?
    var str_project_cod:String?
    var num_project_id:Int?
    var str_taskname:String?
    var num_task_id:Int?
    var num_time_expected:Float?
    
    private enum CodingKeys: String, CodingKey {
        case str_project_name = "str_project_name"
        case str_project_cod = "str_project_cod"
        case num_project_id = "num_project_id"
        case str_taskname = "str_taskname"
        case num_task_id = "num_task_id"
        case num_time_expected = "num_time_expected"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        str_project_name = try container.decode(String?.self, forKey: .str_project_name)
        str_project_cod = try container.decode(String?.self, forKey: .str_project_cod)
        num_project_id = try container.decode(Int?.self, forKey: .num_project_id)	
        str_taskname = try container.decode(String?.self, forKey: .str_taskname)
        num_task_id = try container.decode(Int?.self, forKey: .num_task_id)
        num_time_expected = try container.decode(Float?.self, forKey: .num_time_expected)
    }
    
}
