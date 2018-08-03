//
//  Employee.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

class Employee: Decodable {
    var vch_cod_empleado : String?
    var vch_empleado : String?
    var foto : String?
    
    private enum CodingKeys: String, CodingKey {
        case vch_cod_empleado = "vch_cod_empleado"
        case vch_empleado = "vch_empleado"
        case foto = "foto"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vch_cod_empleado = try container.decode(String?.self, forKey: .vch_cod_empleado)
        vch_empleado = try container.decode(String?.self, forKey: .vch_empleado)
        foto = try container.decode(String?.self, forKey: .foto)
    }
    
}
