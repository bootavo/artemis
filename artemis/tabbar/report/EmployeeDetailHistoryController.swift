//
//  EmployeeDetailHistoryController.swift
//  artemis
//
//  Created by VF Consulting on 7/08/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class EmployeeDetailHistoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var refreshHelper:RefreshControlHelper? = nil
    var assistances = [AssistenceModel]()
    
    var employee: Employee? {
        didSet{
            navigationItem.title = employee?.vch_empleado
        }
    }
    
    private let cellId:String = "AssistanceCell"
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(AssistanceCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
        refreshHelper = RefreshControlHelper(v: self.view, cv: collectionView!, rc: refreshControl)
        refreshHelper?.refreshAction = refreshData
        refreshHelper?.showRefreshControl()
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Detalle"
        titleLabel.font = UIFont.systemFont(ofSize: 8)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        //self.navigationItem.titleView = titleLabel
    }
    
    let iv_not_wifi: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "ic_disconnect")
        iv.contentMode = .scaleAspectFill
        iv.isHidden = true
        return iv
    }()
    
    let tv_message: UITextView = {
        var tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textAlignment = .center
        tv.isHidden = true
        return tv
    }()
    
    func setupView(){
        print("setupView()")
        
        self.view.addSubview(iv_not_wifi)
        iv_not_wifi.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(250)
            make.height.equalTo(250)
            make.center.equalToSuperview()
        }
        
        self.view.addSubview(tv_message)
        tv_message.snp.makeConstraints{
            (make) -> Void in
            make.bottom.equalTo(iv_not_wifi).offset(75)
            make.width.equalTo(300)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
        
        getService()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assistances.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AssistanceCell
        cell.item = self.assistances[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func refreshData(){
        getService()
    }
    
    func getService(){
        if NetworkHelper.isConnectedToNetwork(){
            let code = Defaults[.employee_code]!
            let parameters = ["vch_cod_empleado": employee?.vch_cod_empleado] as [String : Any]
            
            ApiService.sharedInstance.getHistoryAssistance(parameters: parameters) { (err, statusCode, json) in
                
                print("before error")
                
                if let error = err {
                    print("Error: \(error)")
                    self.showServerError(state: true)
                    return
                }
                
                print("statusCode: \(statusCode)")
                if let json = json {
                    let content = json["asistencias"]
                    print("asistencias: \(content)")
                    
                    if !content.isEmpty {
                        do {
                            print("Activities: \(content)")
                            self.assistances = try JSONDecoder().decode([AssistenceModel].self, from: content.rawData())
                            self.collectionView?.reloadData()
                            self.refreshHelper?.stopRefreshControl()
                            self.showNetworkProblems(state: false)
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.view.makeToast("Datos incorrectos")
                            self.refreshHelper?.stopRefreshControl()
                            self.showErrorNotAllowed(state: true)
                        }
                    } else {
                        print("Contenido vacio")
                        self.view.makeToast("No se encontró información")
                        self.refreshHelper?.stopRefreshControl()
                        self.showDataEmpty(state: true)
                    }
                }
            }
        }else {
            self.refreshHelper?.stopRefreshControl()
            
            if assistances.isEmpty {
                self.showNetworkProblems(state: true)
            }else {
                self.view.makeToast("Problemas de conexión a Internet \n Verifica el estado de tu red")
            }
            
        }
        
    }
    
    func showNetworkProblems(state: Bool){
        iv_not_wifi.image = UIImage(named: "ic_disconnect")
        tv_message.text = "Problemas de conexión a Internet \n Desliza hacia abajo para actualizar"
        if state {
            iv_not_wifi.isHidden = false
            tv_message.isHidden = false
        }else {
            iv_not_wifi.isHidden = true
            tv_message.isHidden = true
        }
    }
    
    func showDataEmpty(state: Bool){
        iv_not_wifi.image = UIImage(named: "bg_no_data")
        tv_message.text = "No se encontró información \n Desliza hacia abajo para actualizar"
        if state {
            iv_not_wifi.isHidden = false
            tv_message.isHidden = false
        }else {
            iv_not_wifi.isHidden = true
            tv_message.isHidden = true
        }
    }
    
    func showServerError(state: Bool){
        iv_not_wifi.image = UIImage(named: "bg_error_500")
        tv_message.text = "Lo sentimos, tenemos inconvenientes \n Desliza hacia abajo para actualizar"
        if state {
            iv_not_wifi.isHidden = false
            tv_message.isHidden = false
        }else {
            iv_not_wifi.isHidden = true
            tv_message.isHidden = true
        }
    }
    
    func showErrorNotAllowed(state: Bool){
        iv_not_wifi.image = UIImage(named: "bg_error_notallow")
        tv_message.text = "Problemas con la información \n Desliza hacia abajo para actualizar"
        if state {
            iv_not_wifi.isHidden = true
            tv_message.isHidden = true
        }else {
            iv_not_wifi.isHidden = false
            tv_message.isHidden = false
        }
    }
    
}
