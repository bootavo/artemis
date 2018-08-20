//
//  ListLatersCell.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ListLatersCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var bgHelper: BackgroundHelper? = nil
    var refreshHelper:RefreshControlHelper? = nil
    
    var employees = [EmployeeLater]()
    private let cellId:String = "latersCell"
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
        
        collectionView.register(LaterCell.self, forCellWithReuseIdentifier: cellId)
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LaterCell
        cell.item = self.employees[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 100)
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
            let parameters = ["fecha": "02/08/2018"/*DateHelper().getDateNowToJava()*/] as [String : Any]
            
            ApiService.sharedInstance.getLaters(parameters: parameters) { (err, statusCode, json) in
                
                print("before error")
                
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
                            self.employees = try JSONDecoder().decode([EmployeeLater].self, from: content.rawData())
                            self.collectionView.reloadData()
                            self.stopRefreshControl()
                            self.bgHelper?.showNetworkProblems(state: false)
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.makeToast("Datos incorrectos")
                            self.stopRefreshControl()
                            self.bgHelper?.showErrorNotAllowed(state: true)
                        }
                    } else {
                        print("Contenido vacio")
                        self.makeToast("No se ha podido cargar la lista de empleados que llegaro tarde")
                        self.stopRefreshControl()
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
    
    func setupRefreshControl(){
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.primaryDarkColor()
        
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.primaryDarkColor()]
        refreshControl.attributedTitle = NSAttributedString(string: "Cargando ...", attributes: attributes)
    }
    
    func stopRefreshControl(){
        self.refreshControl.endRefreshing()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        getService()
    }
    
}
