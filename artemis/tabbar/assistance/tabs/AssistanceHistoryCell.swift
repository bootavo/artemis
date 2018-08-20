//
//  HistoryCell.swift
//  artemis
//
//  Created by VF Consulting on 7/16/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class AssistanceHistoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var bgHelper: BackgroundHelper? = nil
    var refreshHelper:RefreshControlHelper? = nil
    var assistances = [AssistenceModel]()
    
    private let cellId:String = "AssistanceCell"
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
        tv.isEditable = false
        return tv
    }()
    
    func setupView(){
        print("setupView()")
        backgroundColor = UIColor.clear
        
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AssistanceCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        refreshHelper = RefreshControlHelper(v: self, cv: collectionView, rc: refreshControl)
        refreshHelper?.refreshAction = refreshData
        refreshHelper?.showRefreshControl()
        
        bgHelper = BackgroundHelper(v: self.contentView, message: nil)
        
        getService()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assistances.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AssistanceCell
        cell.item = self.assistances[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 120)
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
            let parameters = ["vch_cod_empleado": code] as [String : Any]
            
            ApiService.sharedInstance.getHistoryAssistance(parameters: parameters) { (err, statusCode, json) in
                
                print("before error")
                
                if let error = err {
                    print("Error: \(error)")
                    self.bgHelper?.showServerError(state: true)
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
                        self.makeToast("No se ha podido cargar los lugares de trabajo")
                        self.refreshHelper?.stopRefreshControl()
                        self.bgHelper?.showDataEmpty(state: true)
                    }
                }
            }
        }else {
            self.refreshHelper?.stopRefreshControl()
            
            if assistances.isEmpty {
                self.bgHelper?.showNetworkProblems(state: true)
            }else {
                self.makeToast("Problemas de conexión a Internet \n Verifica el estado de tu red")
            }
            
        }
        
    }
    
}







