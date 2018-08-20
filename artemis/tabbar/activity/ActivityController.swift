//
//  ActivityController.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import SwipeCellKit

class ActivityController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var bgHelper: BackgroundHelper? = nil
    var refreshHelper:RefreshControlHelper? = nil
    
    var listActivities:[Task] = []
    private let cellId = "activityCell2"
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //margin top
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) //70 marginTop
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ActiityCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        //self.navigationController?.navigationBar.isTranslucent = false // need specificate when general trnasulcent is false
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Actividades"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
        self.view.addSubview(btn_new_activity)
        btn_new_activity.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-28)
            make.right.equalToSuperview().offset(-28)
        }
        
        refreshHelper = RefreshControlHelper(v: self.view, cv: collectionView!, rc: refreshControl)
        refreshHelper?.refreshAction = refreshData
        refreshHelper?.showRefreshControl()
        
        bgHelper = BackgroundHelper(v: self.view, message: nil)
        
        getService()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    let btn_new_activity: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = UIColor.primaryDarkColor()
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(newActivity), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 10
        btn.layer.masksToBounds = false
        
        let icon:UIImage = UIImage(named: "icon_plus_white")!
        btn.setImage(icon, for: .normal)
        btn.setImage(icon, for: .selected)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        return btn
    }()
    
    let btn_filter: RoundedButton = {
        var btn = RoundedButton()
        btn.addTarget(self, action: #selector(newActivity), for: .touchUpInside)
        btn.setTitle(title: "Filtar", color: UIColor.primaryColor())
        return btn
    }()
    
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
                                print("counting before: \(self.listActivities.count)")
                                self.listActivities.removeAll()
                                print("counting after: \(self.listActivities.count)")
                                self.listActivities = try JSONDecoder().decode([Task].self, from: activities.rawData())
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
            
            if listActivities.isEmpty {
                self.bgHelper?.showNetworkProblems(state: true)
            }else {
                self.view.makeToast("Problemas de conexión a Internet \n Verifica el estado de tu red")
            }
        }
        
    }
    
    @objc func newActivity(){
        print("newActivity")
        let dummySettingsViewController = RegisterActivityController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = "Registrar Nueva Actividad"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //fixed clone cells
        let cellOld = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ActiityCell
        cellOld.contentView.removeFromSuperview()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ActiityCell
        cell.delegate = self
        //cell.item = self.listActivities[indexPath.row]
        cell.updateUI(task: self.listActivities[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 100		)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            
            if !self.listActivities.isEmpty {
                let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
                if translation.y >= 0 {
                    self.btn_new_activity.transform = CGAffineTransform(translationX: 0, y: 0).concatenating(CGAffineTransform(scaleX: 1, y: 1))
                    self.btn_new_activity.alpha = 1
                } else {
                    self.btn_new_activity.transform = CGAffineTransform(translationX: 0, y: -100).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
                    self.btn_new_activity.alpha = 0
                }
                print("Translation: \(translation)")
            }
            
        }, completion: nil)
    }
    
}

extension ActivityController: SwipeCollectionViewCellDelegate{
    
    //Swipe
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Eliminar") { action, indexPath in
            // handle action by updating model with deletion
            self.listActivities.remove(at: indexPath.row)
            action.fulfill(with: .delete)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "ic_trash_gray")
        
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive(automaticallyDelete: false)
        options.transitionStyle = .reveal
        return options
    }
    
}
