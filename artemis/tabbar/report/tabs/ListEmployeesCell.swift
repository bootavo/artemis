//
//  ListEmployeesCell.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ListEmployeesCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var bgHelper: BackgroundHelper? = nil
    var reportController: ReportController?
    var refreshHelper:RefreshControlHelper? = nil
    
    var employees = [Employee]()
    private let cellId:String = "EmployeesCell"
    private let refreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init()")
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    func setupView(){
        print("setupView()")
        backgroundColor = UIColor.clear
        
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        refreshHelper = RefreshControlHelper(v: self, cv: collectionView, rc: refreshControl)
        refreshHelper?.refreshAction = refreshData
        refreshHelper?.showRefreshControl()
        
        bgHelper = BackgroundHelper(v: self.contentView, message: nil)
        
        getService()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employees.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EmployeeCell
        cell.item = self.employees[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("click")
        let employee = employees[indexPath.item]
        reportController?.nextActivity(employee: employee)
    }
    
    func refreshData(){
        getService()
    }
    
    func getService(){
        if NetworkHelper.isConnectedToNetwork(){
            let code = Defaults[.employee_code]!
            let parameters = ["vch_cod_empleado": code] as [String : Any]
            
            ApiService.sharedInstance.getEmployees(parameters: nil) { (err, statusCode, json) in
                
                if let error = err {
                    print("Error: \(error)")
                    self.bgHelper?.showServerError(state: true)
                    return
                }
                
                print("statusCode: \(statusCode)")
                if let json = json {
                    let content = json["empleados"]
                    print("empleados: \(content)")
                    
                    if !content.isEmpty {
                        do {
                            self.employees = try JSONDecoder().decode([Employee].self, from: content.rawData())
                            self.collectionView.reloadData()
                            self.refreshHelper?.stopRefreshControl()
                            self.bgHelper?.showNetworkProblems(state: false)
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.makeToast("Datos incorrectos")
                            self.refreshHelper?.stopRefreshControl()
                            self.bgHelper?.showErrorNotAllowed(state: true)
                        }
                    } else {
                        print("Contenido vacio")
                        self.makeToast("No se ha podido cargar la lista de empleados")
                        self.refreshHelper?.stopRefreshControl()
                        self.bgHelper?.showDataEmpty(state: true)
                    }
                }
            }
        }else {
            self.refreshHelper?.stopRefreshControl()
            
            if employees.isEmpty {
                self.bgHelper?.showNetworkProblems(state: true)
            }else {
                self.makeToast("Problemas de conexión a Internet \n Verifica el estado de tu red")
            }
        }
        
    }
    
}
