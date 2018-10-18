//
//  UserModel.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let employee_code = DefaultsKey<String?>("employee_code")
    static let name = DefaultsKey<String?>("name")
    static let patternLastName = DefaultsKey<String?>("patternLastName")
    static let matternLastName = DefaultsKey<String?>("matternLastName")
    static let foto = DefaultsKey<String?>("foto")
    static let modulesTest = DefaultsKey<[Module]>("modulesTest")
    
    static let moduleAssistance = DefaultsKey<String?>("module")
    static let moduleReport = DefaultsKey<String?>("report")
    static let moduleActivity = DefaultsKey<String?>("activity")
    static let moduleProject = DefaultsKey<String?>("project")
    static let moduleUser = DefaultsKey<String?>("user")
    
    static let projects = DefaultsKey<[Project]>("projects")
    static let tasks = DefaultsKey<[KindOfActivity]>("tasks")
    
}

class UserModel: Decodable {
    
    var employee_code: String?
    var name: String?
    var patternLastName: String?
    var matternLastName: String?
    var modules: [Module]?
    var foto: String?
    
    private enum CodingKeys: String, CodingKey {
        case employee_code = "cod_empleado"
        case name = "nombre"
        case patternLastName = "apellido_paterno"
        case matternLastName = "apellido_materno"
        case modules = "modulos"
        case foto = "foto"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        employee_code = try container.decode(String?.self, forKey: .employee_code)
        name = try container.decode(String?.self, forKey: .name)
        patternLastName = try container.decode(String?.self, forKey: .patternLastName)
        matternLastName = try container.decode(String?.self, forKey: .matternLastName)
        modules = try container.decode([Module]?.self, forKey: .modules)
        foto = try container.decode(String?.self, forKey: .foto)
    }
    
}

class Module: Decodable {
    var vch_cod_modulo: String?
    var vch_nom_modulo: String?
    var sub_modules: [SubModule]?
    private enum CodingKeys: String, CodingKey {
        case vch_cod_modulo
        case vch_nom_modulo
        case sub_modules = "sub_modulos"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vch_cod_modulo = try container.decode(String?.self, forKey: .vch_cod_modulo)
        vch_nom_modulo = try container.decode(String?.self, forKey: .vch_nom_modulo)
        sub_modules = try container.decode([SubModule]?.self, forKey: .sub_modules)
    }
    
}

class SubModule: Decodable {
    var vch_nom_sub_modulo: String?
    var vch_cod_modulo: String?
    
    private enum CodingKeys: String, CodingKey {
        case vch_nom_sub_modulo
        case vch_cod_modulo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vch_cod_modulo = try container.decode(String?.self, forKey: .vch_cod_modulo)
        vch_nom_sub_modulo = try container.decode(String?.self, forKey: .vch_nom_sub_modulo)
    }
}
