//
//  WorkStations.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation

class WorkStations:Decodable {
    var cod_inst_trab:String?
    var nom_inst_trab:String?
    var lat_inst_trab:Double?
    var log_inst_trab:Double?
    var dir_inst_trab:String?
    var puntoAccesos:[AccessPoint]?
    
    private enum CodingKeys: String, CodingKey {
        case cod_inst_trab = "cod_inst_trab"
        case nom_inst_trab = "nom_inst_trab"
        case lat_inst_trab = "lat_inst_trab"
        case log_inst_trab = "log_inst_trab"
        case dir_inst_trab = "dir_inst_trab"
        case puntoAccesos = "puntoAccesos"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dir_inst_trab = try container.decode(String?.self, forKey: .dir_inst_trab)
        nom_inst_trab = try container.decode(String?.self, forKey: .nom_inst_trab)
        lat_inst_trab = try container.decode(Double?.self, forKey: .lat_inst_trab)
        log_inst_trab = try container.decode(Double?.self, forKey: .log_inst_trab)
        dir_inst_trab = try container.decode(String?.self, forKey: .dir_inst_trab)
        puntoAccesos = try container.decode([AccessPoint]?.self, forKey: .puntoAccesos)
    }
    
}

class AccessPoint: Decodable {
    var cod_punt_acc:Int?
    var des_punt_acc:String?
    var cod_inst_trab:String?
    var mac_punt_acc:String?
    
    private enum CodingKeys: String, CodingKey {
        case cod_punt_acc = "cod_punt_acc"
        case des_punt_acc = "des_punt_acc"
        case cod_inst_trab = "cod_inst_trab"
        case mac_punt_acc = "mac_punt_acc"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cod_punt_acc = try container.decode(Int?.self, forKey: .cod_punt_acc)
        des_punt_acc = try container.decode(String?.self, forKey: .des_punt_acc)
        cod_inst_trab = try container.decode(String?.self, forKey: .cod_inst_trab)
        mac_punt_acc = try container.decode(String?.self, forKey: .mac_punt_acc)
    }
    
}

