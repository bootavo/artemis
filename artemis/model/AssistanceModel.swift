//
//  AssistanceModel.swift
//  artemis
//
//  Created by VF Consulting on 8/2/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation

class AssistenceModel: Decodable {
    var vch_cod_empleado : String?
    var fecha : String?
    var tms_time_ini_acti : String?
    var tms_time_fin_acti : String?
    var cantidad_horas : String?
    var vch_nom_ins_tra : String?
    
    private enum CodingKeys: String, CodingKey {
        case vch_cod_empleado = "vch_cod_empleado"
        case fecha = "fecha"
        case tms_time_ini_acti = "tms_time_ini_acti"
        case tms_time_fin_acti = "tms_time_fin_acti"
        case cantidad_horas = "cantidad_horas"
        case vch_nom_ins_tra = "vch_nom_ins_tra"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vch_cod_empleado = try container.decode(String?.self, forKey: .vch_cod_empleado)
        fecha = try container.decode(String?.self, forKey: .fecha)
        tms_time_ini_acti = try container.decode(String?.self, forKey: .tms_time_ini_acti)
        tms_time_fin_acti = try container.decode(String?.self, forKey: .tms_time_fin_acti)
        cantidad_horas = try container.decode(String?.self, forKey: .cantidad_horas)
        vch_nom_ins_tra = try container.decode(String?.self, forKey: .vch_nom_ins_tra)
    }
    
}
