//
//  CategoryProjects.swift
//  artemis
//
//  Created by VF Consulting on 8/08/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation

class CategoryProjects: NSObject{
    
    var category_name : String?
    var projects : [Project]?
    
    /*private enum CodingKeys: String, CodingKey {
        case category_name = "category_name"
        case projects = "projects"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category_name = try container.decode(String?.self, forKey: .category_name)
        projects = try container.decode([Project]?.self, forKey: .projects)
        
    }*/
    
}
