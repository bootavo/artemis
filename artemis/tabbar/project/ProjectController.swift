//
//  ProjectController.swift
//  artemis
//
//  Created by VF Consulting on 8/5/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ProjectController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var bgHelper: BackgroundHelper? = nil
    var refreshHelper:RefreshControlHelper? = nil
    var listProjects:[Project] = []
    
    private let cellId = "projectCell2"
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //margin top
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) //70 marginTop
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ProjectCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        //self.navigationController?.navigationBar.isTranslucent = false // need specificate when general trnasulcent is false
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Proyectos"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
        refreshHelper = RefreshControlHelper(v: self.view, cv: collectionView!, rc: refreshControl)
        refreshHelper?.refreshAction = refreshData
        refreshHelper?.showRefreshControl()
        
        bgHelper = BackgroundHelper(v: self.view, message: nil)
        
        getService()
    }
    
    func refreshData(){
        getService()
    }
    
    func getService() {
        if NetworkHelper.isConnectedToNetwork(){
            let code = Defaults[.employee_code]!
            let parameters = ["str_resource_id": code] as [String : Any]
            
            ApiService.sharedInstance.getActivitiesByResourceId(parameters: parameters) { (err, statusCode, json) in
                
                print("before error")
                
                if let error = err {
                    print("Error: \(error)")
                    self.bgHelper?.showServerError(state: true)
                    return
                }
                
                print("statusCode: \(statusCode)")
                if let json = json {
                    let content = json["content"]
                    print("Content: \(content)")
                    
                    if !content.isEmpty {
                        do {
                            print("activities")
                            
                            let activities = content["activities"]
                            if !activities.isEmpty {
                                print("Activities: \(activities)")
                                self.listProjects = try JSONDecoder().decode([Project].self, from: activities.rawData())
                                self.collectionView?.reloadData()
                                self.refreshHelper?.stopRefreshControl()
                                self.bgHelper?.showNetworkProblems(state: false)
                            }else {
                                print("Actividades vacias")
                                self.refreshHelper?.stopRefreshControl()
                                self.bgHelper?.showDataEmpty(state: true)
                            }
                        }catch let error {
                            print("no se pudo decodificar",error)
                            self.view.makeToast("Datos incorrectos")
                            self.refreshHelper?.stopRefreshControl()
                            self.bgHelper?.showErrorNotAllowed(state: true)
                        }
                    } else {
                        print("Contenido vacio")
                        self.view.makeToast("No se ha podido cargar los lugares de trabajo")
                        self.refreshHelper?.stopRefreshControl()
                        self.bgHelper?.showDataEmpty(state: true)
                    }
                }
            }
        }else {
            self.refreshHelper?.stopRefreshControl()
            
            if listProjects.isEmpty {
                self.bgHelper?.showNetworkProblems(state: true)
            }else {
                self.view.makeToast("Problemas de conexión a Internet \n Verifica el estado de tu red")
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProjectCell
        //cell.item = self.listProjects[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 150        )
    }
    
}
