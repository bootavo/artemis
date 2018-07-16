//
//  AssistanceController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults
import Toast
import CoreLocation

class AssistanceController: UIViewController, CLLocationManagerDelegate{
    
    var assistanceView: AssistanceView!
    
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
    
    override func viewDidLoad() {
        setupMenuBar()
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        configLocationManager()
        //serviceGetWorkStations()
        showTimer()
        defaultUI()
        verifySSIDWifi()
        serviceVerifyAssistance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Title Status Bar White
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Asistencia"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar(){
        
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalToSuperview()
            make.top.equalTo(self.view.snp.top)
        }
        
        assistanceView = AssistanceView(frame: self.view.frame)
        
        self.view.addSubview(assistanceView)
        
        self.view.addSubview(assistanceView)
        assistanceView.snp.makeConstraints{
            (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        }
        self.assistanceView.loginAction = assistanceAction
        
        print("assistanceAction")
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
        dateFormat = "\(day)\(numberDay)\(month)"
        
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
            self.assistanceView.tv_hour.text = "0\(hours)"
        }else {
            self.assistanceView.tv_hour.text = "\(hours)"
        }
        
        if minutes < 10 {
            self.assistanceView.tv_minutes.text = ":0\(minutes)"
        }else {
            self.assistanceView.tv_minutes.text = ":\(minutes)"
        }
        
        self.assistanceView.tv_date.attributedText = dateString
    }
    
    func defaultUI(){
        self.assistanceView.btn_assistance.setTitle("Verificando...", for: .normal)
        self.assistanceView.btn_assistance.isEnabled = false
        self.assistanceView.btn_assistance.setTitleColor(UIColor.white, for: .normal)
        self.assistanceView.btn_assistance.backgroundColor = UIColor.primaryDarkColor()
        self.assistanceView.iv_not_wifi.isHidden = true
        self.assistanceView.tv_message.isHidden = true
    }
    
    func hideTimer(){
        self.assistanceView.tv_hour.isHidden = true
        self.assistanceView.tv_minutes.isHidden = true
        self.assistanceView.tv_date.isHidden = true
        self.assistanceView.tv_network.isHidden = true
        self.assistanceView.iv_network.isHidden = true
        self.assistanceView.iv_circle.isHidden = true
        self.assistanceView.btn_assistance.isHidden = true
    }
    
    func visibilityTimer(){
        self.assistanceView.tv_hour.isHidden = false
        self.assistanceView.tv_minutes.isHidden = false
        self.assistanceView.tv_date.isHidden = false
        //self.assistanceView.tv_network.isHidden = false
        //self.assistanceView.iv_network.isHidden = false
        self.assistanceView.iv_circle.isHidden = false
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
        self.assistanceView.iv_not_wifi.isHidden = false
        self.assistanceView.tv_message.isHidden = false
        self.assistanceView.tv_message.text = "Problemas de Conexión a Internet"
        self.assistanceView.btn_assistance.setTitle("INTENTAR NUEVAMENTE", for: .normal)
        self.assistanceView.btn_assistance.setTitleColor(UIColor.white, for: .normal)
        self.assistanceView.btn_assistance.isHidden = false
        self.assistanceView.btn_assistance.isEnabled = true
    }
    
    func hideNetworkProblems(){
        self.assistanceView.iv_not_wifi.isHidden = true
        self.assistanceView.tv_message.isHidden = true
    }
    
    func showFarAway(){
        self.assistanceView.iv_not_wifi.isHidden = false
        self.assistanceView.iv_not_wifi.image = UIImage(named: "ic_build_icono")
        self.assistanceView.tv_message.isHidden = false
        self.assistanceView.tv_message.text = """
        Te encuentras lejos de una red VF
        Estación de trabajo más cercana:
        \(early_roouter)
        """
        self.assistanceView.btn_assistance.setTitle("INTENTAR NUEVAMENTE", for: .normal)
        self.assistanceView.btn_assistance.setTitleColor(UIColor.white, for: .normal)
        self.assistanceView.btn_assistance.isHidden = false
    }
    
    func hideFarAway(){
        self.assistanceView.iv_not_wifi.isHidden = true
        self.assistanceView.tv_message.isHidden = true
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
                            self.view.makeToast("Datos incorrectos")
                        }
                    } else {
                        print("can't verify assitance")
                        self.view.makeToast("No se ha podido verificar la asistencia")
                        self.showNetworkProblems()
                    }
                } else {
                    self.view.makeToast("Intentelo nuevamente")
                    print("no se pudo decodificar")
                    self.showNetworkProblems()
                }
            }
        } else {
            self.view.makeToast("Verifique su conexión a internet")
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
        self.assistanceView.btn_assistance.isHidden = false
        self.assistanceView.btn_assistance.isEnabled = false
        if !isFakeLocation {
            self.assistanceView.btn_assistance.setTitle("ASISTENCIAS COMPLETADAS", for: .disabled)
            self.assistanceView.btn_assistance.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func markEntry(){
        print("You need to mark the first entry of this day")
        //Show button -> "Marcar Entrada"
        self.assistanceView.btn_assistance.isHidden = false
        self.assistanceView.btn_assistance.isEnabled = true
        if !isFakeLocation {
            self.assistanceView.btn_assistance.setTitle("MARCAR ENTRADA", for: .normal)
            self.assistanceView.btn_assistance.backgroundColor = UIColor.primaryDarkColor()
            self.assistanceView.btn_assistance.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func checkOut(){
        print("You need to mark your checkout of work")
        //Show button -> "Marcar Salida"
        self.assistanceView.btn_assistance.isHidden = false
        self.assistanceView.btn_assistance.isEnabled = true
        if !isFakeLocation {
            self.assistanceView.btn_assistance.setTitle("MARCAR SALIDA", for: .normal)
            self.assistanceView.btn_assistance.backgroundColor = UIColor.primaryDarkColor()
            self.assistanceView.btn_assistance.setTitleColor(UIColor.white, for: .normal)
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
                            self.view.makeToast("Datos incorrectos")
                        }
                    } else {
                        print("No se ha podido cargar los lugares de trabajo")
                        self.view.makeToast("No se ha podido cargar los lugares de trabajo")
                        
                    }
                } else {
                    self.view.makeToast("Intentelo nuevamente")
                    print("no se pudo decodificar")
                    self.showNetworkProblems()
                }
            }
            print("/End serviceGetWorkStations()")
        } else {
            self.view.makeToast("Verifique su conexión a internet")
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
        print("----->")
        let current_coordinate = CLLocation(latitude: lat!, longitude: lng!)
        let work_coordinate = CLLocation(latitude: lat_work, longitude: lng_work)
        
        let distanceInMeters = current_coordinate.distance(from: work_coordinate)
        print("----------> calculateMetters(): \(distanceInMeters)")
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
                distanceInMeters == new_distance
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
                self.view.makeToast("Fuera de rango, te faltan \(distance) m")
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
        self.assistanceView.tv_network.text = "Conectado a la red \n\(ssid)"
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
                self.view.makeToast("Asegurate de estar conectado a una red autorizada")
            }
        }
        
    }
    
    func clearInterfaces(){
        hideNetworkProblems()
        hideFarAway()
        hideTimer()
    }
    
    func assistanceAction(){
        print("xd")
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
                    self.view.makeToast("Registro satisfactorio")
                    self.checkOut()
                }else {
                    print("no se ha podido registrar, Intentelo nuevamente")
                    self.view.makeToast("No se ha podido registrar, Intentlo nuevamente")
                }
            }
        } else {
            self.view.makeToast("Verifique su conexión a internet")
            print("no se pudo decodificar")
            showNetworkProblems()
        }
    }
    
    func showButtonName(){
        defaultUI()
        self.assistanceView.btn_assistance.isEnabled = true
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
                                    self.view.makeToast("Registro satisfactorio")
                                    self.congrats()
                                }else {
                                    print("no se ha podido registrar, Intentelo nuevamente")
                                    self.view.makeToast("No se ha podido registrar, Intentlo nuevamente")
                                }
                            }
                            
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.view.makeToast("Datos incorrectos")
                        }
                    } else {
                        print("can't verify assitance")
                        self.view.makeToast("No se ha podido verificar la asistencia")
                        self.showNetworkProblems()
                    }
                } else {
                    self.view.makeToast("Intentelo nuevamente")
                    print("no se pudo decodificar")
                    self.showNetworkProblems()
                }
            }
            
        } else {
            self.view.makeToast("Verifique su conexión a internet")
            print("no se pudo decodificar")
            showNetworkProblems()
        }
    }
    
}
