//
//  RegisterCell.swift
//  artemis
//
//  Created by VF Consulting on 7/17/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults
import Toast
import CoreLocation

class RegisterAssistanceCell: UICollectionViewCell, CLLocationManagerDelegate {
    
    var registerView: RegisterAssistanceView!
    
    var locationManager = CLLocationManager()
    var lat:Double?
    var lng:Double?
    
    var TAG:String = "Register"
    
    var condition:Bool = false
    var early_roouter:String = ""
    
    var isFakeLocation:Bool = false
    var networkState:Bool = false
    
    var listWorkStations:[WorkStations] = []
    var listAccesPoint:[AccessPoint] = []
    
    var cod_inst_trab:String? = nil
    var num_cod_acti_empl:Int? = nil
    var lat_work:Double = 0
    var lng_work:Double = 0
    var cod_res_ver_asis:Int = 0;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init()")
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let registerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupView(){
        print("setupView()")
        backgroundColor = UIColor.black
        
        addSubview(registerCollectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": registerCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": registerCollectionView]))
        
        let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        registerView = RegisterAssistanceView(frame: rect)
        registerCollectionView.addSubview(registerView!)
        
        self.registerView.registerAction = assistanceAction
        
        //Used in another interface
        //addConstraintsWithFormat(format: "H:|[v0]|", views: registerView)
        //addConstraintsWithFormat(format: "V:|[v0]|", views: registerView)
        
        configLocationManager()
        serviceGetWorkStations()
        showTimer()
        defaultUI()
        verifySSIDWifi()
        serviceVerifyAssistance()
    }
    
    func configLocationManager(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            print("NotDetermined")
            break
            
        case .restricted, .denied:
            // Disable location features
            print("Restricted")
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            print("AuthorizedWhenInUse")
            locationManager.startUpdatingLocation()
            guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            lat = locValue.latitude
            lng = locValue.longitude
            break
        }
    }
    
    func showTimer(){
        self.setTimer()
        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            (_) in
            self.setTimer()
        }
    }
    
    func setTimer(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/d/MMM"
        var dateFormat = formatter.string(from: Date())
        
        let fullNameArr = dateFormat.components(separatedBy: "/")
        let day    = fullNameArr[0]
        let numberDay = fullNameArr[1]
        let month = fullNameArr[2]
        
        if Int(numberDay)! < 10 {
            dateFormat = "\(day)0\(numberDay)\(month)"
        }else{
            dateFormat = "\(day)\(numberDay)\(month)"
        }
        
        var dateString = NSMutableAttributedString (string: "\(dateFormat)")
        let bigBoldFont = UIFont.boldSystemFont(ofSize: 26)
        let bigFont = UIFont.systemFont(ofSize: 26)
        dateString.addAttribute(NSAttributedStringKey.font, value: bigFont, range: NSRange(location: 3,length: 2))
        
        let date = Date()
        let calendar = Calendar.current
        
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        if hours < 10 {
            self.registerView.tv_hour.text = "0\(hours)"
        }else {
            self.registerView.tv_hour.text = "\(hours)"
        }
        
        if minutes < 10 {
            self.registerView.tv_minutes.text = ":0\(minutes)"
        }else {
            self.registerView.tv_minutes.text = ":\(minutes)"
        }
        
        self.registerView.tv_date.attributedText = dateString
    }
    
    func defaultUI(){
        self.registerView.btn_assistance.setTitle(title: "Verificando...", color: UIColor.primaryColor())
        self.registerView.btn_assistance.isEnabled = false
        self.registerView.btn_assistance.backgroundColor = UIColor.primaryDarkColor()
        self.registerView.btn_assistance.layer.borderColor = UIColor.primaryDarkColor().cgColor
        self.registerView.iv_not_wifi.isHidden = true
        self.registerView.tv_network.isHidden = false
        self.registerView.iv_network.isHidden = false
        self.registerView.tv_message.isHidden = true
    }
    
    func hideTimer(){
        self.registerView.tv_hour.isHidden = true
        self.registerView.tv_minutes.isHidden = true
        self.registerView.tv_date.isHidden = true
        self.registerView.tv_network.isHidden = true
        self.registerView.iv_network.isHidden = true
        self.registerView.iv_circle.isHidden = true
        self.registerView.btn_assistance.isHidden = true
    }
    
    func visibilityTimer(){
        self.registerView.tv_hour.isHidden = false
        self.registerView.tv_minutes.isHidden = false
        self.registerView.tv_date.isHidden = false
        //self.assistanceView.tv_network.isHidden = false
        //self.assistanceView.iv_network.isHidden = false
        self.registerView.iv_circle.isHidden = false
        defaultUI()
    }
    
    func verifyNetwork() -> Bool{
        if NetworkHelper.isConnectedToNetwork(){
            print("Hay internet!")
            networkState = true
            return true
        }else{
            hideTimer()
            hideFarAway()
            showNetworkProblems()
            print("No hay conexión a internet!")
            networkState = false
            return false
        }
    }
    
    func showNetworkProblems(){
        //Show UI Network Problems with image
        self.registerView.iv_not_wifi.isHidden = false
        self.registerView.iv_not_wifi.image = UIImage(named: "ic_disconnect")
        self.registerView.tv_message.isHidden = false
        self.registerView.tv_message.text = "Problemas de Conexión a Internet"
        self.registerView.btn_assistance.setTitle(title: "INTENTAR NUEVAMENTE", color: UIColor.primaryColor())
        self.registerView.btn_assistance.isHidden = false
        self.registerView.btn_assistance.isEnabled = true
    }
    
    func hideNetworkProblems(){
        self.registerView.iv_not_wifi.isHidden = true
        self.registerView.tv_message.isHidden = true
    }
    
    func showFarAway(){
        self.registerView.iv_not_wifi.isHidden = false
        self.registerView.iv_not_wifi.image = UIImage(named: "ic_faraway")
        self.registerView.tv_message.isHidden = false
        self.registerView.tv_message.text = """
        Te encuentras lejos de una red VF
        Estación de trabajo más cercana:
        \(early_roouter)
        """
        self.registerView.btn_assistance.setTitle(title: "INTENTAR NUEVAMENTE", color: UIColor.primaryColor())
        self.registerView.btn_assistance.isHidden = false
    }
    
    func hideFarAway(){
        self.registerView.iv_not_wifi.isHidden = true
        self.registerView.tv_message.isHidden = true
    }
    
    func serviceVerifyAssistance(){
        print("--------> serviceVerifyAssistance")
        defaultUI()
        if verifyNetwork() {
            print("true")
            let code = Defaults[.employee_code]!
            let parameters = ["vch_cod_empleado" : code] as [String : Any]
            ApiService.sharedInstance.verifyssistance(parameters: parameters){ (err, statusCode, json) in
                if let error = err {
                    print(error)
                    return
                }
                print(statusCode)
                if let json = json {
                    let asistencia = json["asistencia"]
                    
                    if !asistencia.isEmpty {
                        do {
                            print("getVerifyAssistance")
                            
                            let user = try JSONDecoder().decode(VerifyAssistance.self, from: asistencia.rawData())
                            
                            self.num_cod_acti_empl = user.num_cod_acti_empl!
                            
                            let int_code = user.num_cod_acti_empl!
                            self.cod_res_ver_asis = int_code // Used to show name of button after wifi validation
                            
                            print("num_cod_acti_eml: \(int_code)")
                            self.updateUserInterface(cod: int_code)
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.makeToast("Datos incorrectos")
                        }
                    } else {
                        print("can't verify assitance")
                        self.makeToast("No se ha podido verificar la asistencia")
                        self.showNetworkProblems()
                    }
                } else {
                    self.makeToast("Intentelo nuevamente")
                    print("no se pudo decodificar")
                    self.showNetworkProblems()
                }
            }
        } else {
            self.makeToast("Verifique su conexión a internet")
            print("no se pudo decodificar")
            showNetworkProblems()
        }
        
    }
    
    func updateUserInterface(cod: Int){
        print("cod user interface to update= \(cod)")
        if cod == -1 {
            congrats()
        }else if cod == 0 {
            condition = true
            markEntry()
        }else {
            checkOut()
        }
    }
    
    func congrats(){
        print("Congratulations, you mark all entries of this day.")
        //Hide button and  say the next message -> "Gracias por marcar tus asistencias"
        self.registerView.btn_assistance.isHidden = false
        self.registerView.btn_assistance.isEnabled = false
        if !isFakeLocation {
            print("isFakeLocation")
            self.registerView.btn_assistance.setTitle(title: "ASISTENCIAS COMPLETADAS", color: UIColor.primaryColor())
            self.registerView.btn_assistance.backgroundColor = UIColor.gray
            self.registerView.btn_assistance.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func markEntry(){
        print("You need to mark the first entry of this day")
        //Show button -> "Marcar Entrada"
        self.registerView.btn_assistance.isHidden = false
        self.registerView.btn_assistance.isEnabled = true
        if !isFakeLocation {
            self.registerView.btn_assistance.setTitle(title: "MARCAR ENTRADA", color: UIColor.primaryColor())
            self.registerView.btn_assistance.backgroundColor = UIColor.primaryDarkColor()
            self.registerView.btn_assistance.layer.borderColor = UIColor.primaryDarkColor().cgColor
        }
    }
    
    func checkOut(){
        print("You need to mark your checkout of work")
        //Show button -> "Marcar Salida"
        self.registerView.btn_assistance.isHidden = false
        self.registerView.btn_assistance.isEnabled = true
        if !isFakeLocation {
            self.registerView.btn_assistance.setTitle(title: "MARCAR SALIDA", color: UIColor.primaryColor())
            self.registerView.btn_assistance.backgroundColor = UIColor.primaryDarkColor()
            self.registerView.btn_assistance.layer.borderColor = UIColor.primaryDarkColor().cgColor
        }
    }
    
    func serviceGetWorkStations(){
        print("1. --------> serviceGetWorkStations()")
        if verifyNetwork() {
            ApiService.sharedInstance.getWorkStations(parameters: nil){ (err, statusCode, json) in
                if let error = err {
                    print(error)
                    return
                }
                
                if let json = json {
                    let workStations = json["lugaresTrabajo"]
                    
                    if !workStations.isEmpty {
                        do {
                            print("1.1 Workstation with data")
                            
                            //caste seguro
                            let station = try JSONDecoder().decode([WorkStations].self, from: workStations.rawData())
                            self.listWorkStations = station
                            
                        }catch let error {
                            print(self.TAG+"no se pudo decodificar",error)
                            self.makeToast("Datos incorrectos")
                        }
                    } else {
                        print("No se ha podido cargar los lugares de trabajo")
                        self.makeToast("No se ha podido cargar los lugares de trabajo")
                        
                    }
                } else {
                    self.makeToast("Intentelo nuevamente")
                    print("no se pudo decodificar")
                    self.showNetworkProblems()
                }
            }
            print("/End serviceGetWorkStations()")
        } else {
            makeToast("Verifique su conexión a internet")
            print("Verifique su conexión a internet")
            print("showNetworkProblems()")
            showNetworkProblems()
        }
    }
    
    func getLocationMoreEarly() -> Bool{
        let current_router:String = getSSIDWifi()
        var status:Bool = false
        
        for workStation in listWorkStations{
            if !(workStation.puntoAccesos?.isEmpty)!{
                print("getLocationMoreEarly workStation with data")
                print("getLocationMoreEarly current SSID: \(current_router)")
                for accessPoint in workStation.puntoAccesos! {
                    if current_router == accessPoint.des_punt_acc{
                        lat_work = workStation.lat_inst_trab!
                        lng_work = workStation.log_inst_trab!
                        print("Lugar de Trabajo \(workStation.cod_inst_trab!)")
                        status = true
                    }
                }
            }else{
                status = false;
            }
        }
        print("---> getLocationMoreEarly() \(status)")
        return status
    }
    
    func calculateMetters() -> Double{
        print("-----> calculateMetters()")
        let current_coordinate = CLLocation(latitude: lat!, longitude: lng!)
        let work_coordinate = CLLocation(latitude: lat_work, longitude: lng_work)
        
        let distanceInMeters = current_coordinate.distance(from: work_coordinate)
        print("calculateMetters: \(distanceInMeters)")
        print("CC: \(current_coordinate)")
        print("lat: \(lat) - Lng: \(lng)")
        print("WTD: \(work_coordinate)")
        print("lat: \(lat_work) - Lng: \(lng_work)")
        print("----->")
        return distanceInMeters
    }
    
    func verifDistanceToWorkStation() -> Bool {
        print("---------> verifDistyanceToWorkStation()")
        var state:Bool = false
        
        var distanceInMeters = calculateMetters()
        
        var minDistance:Double = 99999999.0
        
        if !self.listWorkStations.isEmpty {
            for workStations in self.listWorkStations {
                self.lat_work = workStations.lat_inst_trab!
                self.lng_work = workStations.log_inst_trab!
                self.cod_inst_trab = workStations.cod_inst_trab!
                
                let new_distance = self.calculateMetters()
                distanceInMeters = new_distance
                print("Distancia en metros: \(new_distance)")
                
                if(new_distance < minDistance){
                    minDistance = new_distance
                    early_roouter = workStations.nom_inst_trab!
                }
                print("Workstation more early: \(early_roouter)")
                print("Workstation in metters: \(minDistance)")
            }
            
            if minDistance < 100 {
                state = true
                isFakeLocation = false
                hideFarAway()
                visibilityTimer()
                print("Estás en el rango")
                isFakeLocation = false
            }else {
                var distance = round(minDistance)
                makeToast("Fuera de rango, te faltan \(distance) m")
                isFakeLocation = true
                state = false
                hideTimer()
                showFarAway()
                print("No estás en el rango")
                isFakeLocation = true
            }
            
        }else  {
            state = false
            self.serviceGetWorkStations()
        }
        return state
    }
    
    func verifyWorkLocation() -> Bool{
        print("---------> verifyWorkLocation()")
        if getLocationMoreEarly(){
            if lat_work != 0 && lng_work != 0 {
                print("---------> true")
                return true
            }else {
                print("---------> false")
                return false
            }
        }else{
            return false
        }
        
    }
    
    func verifyCurrentLocation() -> Bool {
        print("---------> verifyCurrentLocation()")
        
        if lat != 0 && lng != 0 {
            print("---------> true")
            return true
        }else {
            print("---------> false)")
            return false
        }
    }
    
    func changeNameWifi(ssid:String){
        self.registerView.tv_network.text = "Conectado a la red \n\(ssid)"
    }
    
    func verifySSIDWifi() -> Bool {
        print("---------> verifySSIDWifi()")
        var state:Bool = false
        let ssid:String = getSSIDWifi()
        print("SSID: \(ssid)")
        if !ssid.isEmpty || ssid != "" {
            print("Router or Wifi name: \(ssid)")
            changeNameWifi(ssid: ssid)
            
            if !listWorkStations.isEmpty {
                for workStations in listWorkStations {
                    lat_work = workStations.lat_inst_trab!
                    lng_work = workStations.log_inst_trab!
                    cod_inst_trab = workStations.cod_inst_trab!
                    for accespoint in workStations.puntoAccesos! {
                        if (accespoint.des_punt_acc == ssid) {
                            state = true
                            return true
                        }else {
                            state = false
                        }
                    }
                }
            }else  {
                print("second serviceGetWorkStation")
                serviceGetWorkStations()
                showNetworkProblems()
            }
            
        }else {
            print("Can't identify wifi name")
            changeNameWifi(ssid: "3G/4G de tus Datos")
        }
        return state
    }
    
    func getSSIDWifi() -> String {
        print("---------> getSSIDWifi")
        if verifyNetwork() {
            return SSIDHelper.fetchSSIDInfo()
        }else {
            showNetworkProblems()
            return ""
        }
    }
    
    func serviceMark(){
        print("---------> serviceMark")
        if verifDistanceToWorkStation() { //Check to distance to work station
            if verifySSIDWifi() { //Check red authorized
                if(verifyCurrentLocation() && verifyWorkLocation() && verifDistanceToWorkStation()){
                    if condition {
                        serviceRegisterEntry()
                    }else {
                        serviceRegisterCheckOut()
                    }
                    print("---------> go to post service")
                }else {
                    print("not yet")
                }
                
            }else {
                showButtonName()
                print("Asegurate de estar conectado a una red WIFI test");
                makeToast("Asegurate de estar conectado a una red autorizada")
                
            }
        }
        
    }
    
    func clearInterfaces(){
        hideNetworkProblems()
        hideFarAway()
        hideTimer()
    }
    
    //Register Assitance
    func assistanceAction(){
        print("assistanceAction")
        let network:Bool = verifyNetwork()
        if network {
            clearInterfaces()
            visibilityTimer()
            
            showButtonName()
            
            print("clicked networkState: \(networkState)")
            print("clicked isFakeLocation: \(isFakeLocation)")
            
            if(!networkState){
                print("Se ha vuelto a reconectar a internet")
                if(isFakeLocation){
                    print("Se ha vuelto a estar dentro del rango")
                }
            }else{
                serviceMark()
            }
        } else {
            hideTimer()
            hideFarAway()
            showNetworkProblems()
        }
    }
    
    func serviceRegisterEntry() {
        print("--------> serviceRegisterEntry")
        if verifyNetwork() {
            let code = Defaults[.employee_code]!
            let vch_des_acti_empl = "MICROSERVICIO PRUEBA"
            
            let auditoria = ["vch_usuario_crea": code]
            
            let parameters = ["vch_cod_empleado": code, "vch_cod_ins_tra": cod_inst_trab!, "vch_des_acti_empl": vch_des_acti_empl, "auditoria": auditoria] as [String : Any]
            
            print("Paramtros de envío: \(parameters)")
            
            ApiService.sharedInstance.registerEntry(parameters: parameters){ (err, statusCode, json) in
                if let error = err {
                    print(error)
                    return
                }
                print(statusCode)
                let message:String? = json!["mensaje"].stringValue
                if message == nil || (message?.isEmpty)! {
                    self.condition = false
                    print("success")
                    self.makeToast("Registro satisfactorio")
                    self.checkOut()
                }else {
                    print("no se ha podido registrar, Intentelo nuevamente")
                    self.makeToast("No se ha podido registrar, Intentlo nuevamente")
                }
            }
        } else {
            makeToast("Verifique su conexión a internet")
            print("no se pudo decodificar")
            showNetworkProblems()
        }
    }
    
    func showButtonName(){
        defaultUI()
        self.registerView.btn_assistance.isEnabled = true
        updateUserInterface(cod: cod_res_ver_asis)
    }
    
    func serviceRegisterCheckOut(){
        print("--------> serviceRegisterCheckOut")
        if verifyNetwork() {
            
            let code = Defaults[.employee_code]!
            let parameters_verify = ["vch_cod_empleado" : code] as [String : Any]
            ApiService.sharedInstance.verifyssistance(parameters: parameters_verify){ (err, statusCode, json) in
                if let error = err {
                    print(error)
                    return
                }
                print(statusCode)
                if let json = json {
                    let asistencia = json["asistencia"]
                    
                    if !asistencia.isEmpty {
                        do {
                            print("getVerifyAssistance")
                            
                            let user = try JSONDecoder().decode(VerifyAssistance.self, from: asistencia.rawData())
                            
                            self.num_cod_acti_empl = user.num_cod_acti_empl!
                            
                            let int_code = user.num_cod_acti_empl!
                            
                            print("num_cod_acti_eml: \(int_code)")
                            
                            self.cod_res_ver_asis = int_code // Used to show name of button after wifi validation
                            
                            let parameters = ["vch_cod_empleado": code, "num_cod_acti_empl": self.num_cod_acti_empl] as [String : Any]
                            print("Parametros checkout: \(parameters)")
                            
                            ApiService.sharedInstance.registerCheckout(parameters: parameters){ (err, statusCode, json) in
                                if let error = err {
                                    print(error)
                                    return
                                }
                                print(statusCode)
                                let message:String? = json!["mensaje"].stringValue
                                if message == nil || (message?.isEmpty)! {
                                    print("success")
                                    self.makeToast("Registro satisfactorio")
                                    self.congrats()
                                }else {
                                    print("no se ha podido registrar, Intentelo nuevamente")
                                    self.makeToast("No se ha podido registrar, Intentlo nuevamente")
                                }
                            }
                            
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.makeToast("Datos incorrectos")
                        }
                    } else {
                        print("can't verify assitance")
                        self.makeToast("No se ha podido verificar la asistencia")
                        self.showNetworkProblems()
                    }
                } else {
                    self.makeToast("Intentelo nuevamente")
                    print("no se pudo decodificar")
                    self.showNetworkProblems()
                }
            }
            
        } else {
            makeToast("Verifique su conexión a internet")
            print("no se pudo decodificar")
            showNetworkProblems()
        }
    }
    
}
