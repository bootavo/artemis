//
//  EployeeLater.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

class EmployeeLater: Decodable {
    var vch_cod_empleado : String?
    var vch_empleado : String?
    var foto : String?
    var tms_time_ini_acti : String?
    var tiempo_tarde : String?
    var vch_nom_ins_tra : String?
    
    private enum CodingKeys: String, CodingKey {
        case vch_cod_empleado = "vch_cod_empleado"
        case vch_empleado = "vch_empleado"
        case foto = "foto"
        case tms_time_ini_acti = "tms_time_ini_acti"
        case tiempo_tarde = "tiempo_tarde"
        case vch_nom_ins_tra = "vch_nom_ins_tra"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vch_cod_empleado = try container.decode(String?.self, forKey: .vch_cod_empleado)
        vch_empleado = try container.decode(String?.self, forKey: .vch_empleado)
        foto = try container.decode(String?.self, forKey: .foto)
        tms_time_ini_acti = try container.decode(String?.self, forKey: .tms_time_ini_acti)
        tiempo_tarde = try container.decode(String?.self, forKey: .tiempo_tarde)
        vch_nom_ins_tra = try container.decode(String?.self, forKey: .vch_nom_ins_tra)
    }
    
}
