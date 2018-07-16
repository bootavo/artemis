//
//  VerifyAssistance.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation

class VerifyAssistance: Decodable {
    var num_cod_acti_empl:Int?
    var vch_cod_empleado:String?
    
    private enum CodingKeys: String, CodingKey {
        case num_cod_acti_empl = "num_cod_acti_empl"
        case vch_cod_empleado = "vch_cod_empleado"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        num_cod_acti_empl = try container.decode(Int?.self, forKey: .num_cod_acti_empl)
        vch_cod_empleado = try container.decode(String?.self, forKey: .vch_cod_empleado)
    }
    
}

