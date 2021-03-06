//
//  ApiServices.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func login( parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        let url = "https://678qymr0y7.execute-api.us-east-1.amazonaws.com/PRODENV/Sigap/login"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfTE9HSU46VkYkQ09OU1VMVElOR19MT0dJTg==",
            "cache-control": "no-cache",
            ]
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func getHistoryAssistance(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        let url = "https://cxmvvi65z6.execute-api.us-east-1.amazonaws.com/PRODENV/Asistencia/historialAsistencias"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfSElTVE9SSUFMLUFTSVNURU5DSUFTOlZGJENPTlNVTFRJTkdfSElTVE9SSUFMLUFTSVNURU5DSUFT",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func getActivitiesByResourceId(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        var url = "https://kchhyxd33f.execute-api.us-east-1.amazonaws.com/prod/artemis/activities"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Basic YXJ0ZW1pczpyM2JWVTFsZDNyTDRi",
            "Cache-Control": "no-cache"
        ]
        
        request(url: url, httpMethod: .get, headers: headers, parameters: parameters, encoding: URLEncoding.default, completion: completion)
    }
    
//    num_activity_id
    func deleteActivityById(id:Int,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        var url = "https://kchhyxd33f.execute-api.us-east-1.amazonaws.com/prod/artemis/activities/\(id)"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Basic YXJ0ZW1pczpyM2JWVTFsZDNyTDRi",
            "Cache-Control": "no-cache"
        ]
        
        request(url: url, httpMethod: .delete, headers: headers, parameters: nil, encoding: JSONEncoding.default, completion: completion)
    }
    
    func getTasksByProjectId(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        var url = "https://853ufpi521.execute-api.us-east-1.amazonaws.com/dev/artemis/activities"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Basic YXJ0ZW1pczpyM2JWVTFsZDNyTDRi",
            "Cache-Control": "no-cache"
            ]
        
        request(url: url, httpMethod: .get, headers: headers, parameters: parameters, encoding: URLEncoding.default, completion: completion)
    }
    
    func getProjectsByResourceId(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        var url = "https://5zc7ep3gjb.execute-api.us-east-1.amazonaws.com/prod/artemis/project_teams"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Basic YXJ0ZW1pczpyM2JWVTFsZDNyTDRi",
            "Cache-Control": "no-cache"
        ]
        
        request(url: url, httpMethod: .get, headers: headers, parameters: parameters, encoding: URLEncoding.default, completion: completion)
    }
    
    func registerActivity(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        var url = "https://kchhyxd33f.execute-api.us-east-1.amazonaws.com/prod/artemis/activities"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Basic YXJ0ZW1pczpyM2JWVTFsZDNyTDRi",
            "Cache-Control": "no-cache"
        ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func getKindOfActivities(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ) {
        
        var url = "https://6xgzmzqrc8.execute-api.us-east-1.amazonaws.com/prod/artemis/tasks"
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Basic YXJ0ZW1pczpyM2JWVTFsZDNyTDRi",
            "Cache-Control": "no-cache"
        ]
        
        request(url: url, httpMethod: .get, headers: headers, parameters: parameters, encoding: URLEncoding.default, completion: completion)
    }
    
    func getWorkStations(parameters: Parameters?, completion: @escaping (Error?,Int,JSON?) -> () ){
        let url = "https://nyxt07jpb8.execute-api.us-east-1.amazonaws.com/PRODENV/LugarTrabajo/listar"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfTElTVEFSLUxVR1RSQUJBSk86VkYkQ09OU1VMVElOR19MSVNUQVItTFVHVFJBQkFKTw==",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func verifyssistance(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ){
        let url = "https://gt04wzltkg.execute-api.us-east-1.amazonaws.com/PRODENV/Asistencia/comprobarAsistencia"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfQ09NUFJPQkFSLUFTSVNURU5DSUE6VkYkQ09OU1VMVElOR19DT01QUk9CQVItQVNJU1RFTkNJQQ==",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func registerEntry(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ){
        let url = "https://chzteqor28.execute-api.us-east-1.amazonaws.com/PRODENV/Asistencia/registrarAsistencia"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfUkVHSVNUUkFSLUFTSVNURU5DSUE6VkYkQ09OU1VMVElOR19SRUdJU1RSQVItQVNJU1RFTkNJQQ==",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func registerCheckout(parameters: Parameters,_ completion: @escaping (Error?,Int,JSON?) -> () ){
        let url = "https://k6ld1eetk2.execute-api.us-east-1.amazonaws.com/PRODENV/Asistencia/registrarSalida"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfUkVHSVNUUkFSLVNBTElEQTpWRiRDT05TVUxUSU5HX1JFR0lTVFJBUi1TQUxJREE=",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func getEmployees(parameters: Parameters?, completion: @escaping (Error?,Int,JSON?) -> () ){
        let url = "https://knawll6ko9.execute-api.us-east-1.amazonaws.com/PRODENV/Asistencia/reporteEmpleado"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfUkVQT1JURS1FTVBMRUFETzpWRiRDT05TVUxUSU5HX1JFUE9SVEUtRU1QTEVBRE8=",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func getAbsents(parameters: Parameters?, completion: @escaping (Error?,Int,JSON?) -> () ){
        let url = "https://4wsmg3skw0.execute-api.us-east-1.amazonaws.com/PRODENV/Asistencia/reporteEmpleadoFaltas"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfUkVQT1JURS1FTVBMRUFETy1GQUxUQVM6VkYkQ09OU1VMVElOR19SRVBPUlRFLUVNUExFQURPLUZBTFRBUw==",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    func getLaters(parameters: Parameters?, completion: @escaping (Error?,Int,JSON?) -> () ){
        let url = "https://qttdtifh38.execute-api.us-east-1.amazonaws.com/PRODENV/Asistencia/reporteEmpleadoTardanza"
        let headers = [
            "content-type": "application/json",
            "authorization": "Basic TVNfUkVQT1JURS1FTVBMRUFETy1UQVJEQU5aQTpWRiRDT05TVUxUSU5HX1JFUE9SVEUtRU1QTEVBRE8tVEFSREFOWkE=",
            "cache-control": "no-cache",
            ]
        
        request(url: url, httpMethod: .post, headers: headers, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
    
    //MARK: Request for all methods
    func request(url: String,
                 httpMethod: HTTPMethod,
                 headers: HTTPHeaders?,
                 parameters: Parameters?,
                 encoding: ParameterEncoding,
                 completion: @escaping (Error?,Int,JSON?) -> ()) {
        
        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).responseString { (dataResponse) in
            
            if let error = dataResponse.error {
                DispatchQueue.main.async(execute: {
                    if let statusCode = dataResponse.response?.statusCode {
                        completion(error, statusCode,nil)
                    }else {
                        completion(error,-1,nil)
                    }
                })
                return
            }
            if let data = dataResponse.data, let json = try? JSON.init(data: data),
                let statusCode = dataResponse.response?.statusCode {
                DispatchQueue.main.async(execute: {
                    completion(nil,statusCode,json)
                })
            }
        }
        
    }
    
}
