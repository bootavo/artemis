//
//  ActivityController2.swift
//  artemis
//
//  Created by VF Consulting on 8/3/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class ActivityController2: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
        collectionView?.register(ActiityCell2.self, forCellWithReuseIdentifier: cellId)
        
        getService()
        
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
        setupRefreshControl()
    }
    
    func setupRefreshControl(){
        collectionView?.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.primaryDarkColor()
        
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.primaryDarkColor()]
        refreshControl.attributedTitle = NSAttributedString(string: "Cargando ...", attributes: attributes)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        getService()
    }
    
    func stopRefreshControl(){
        self.refreshControl.endRefreshing()
    }
    
    let btn_new_activity: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = UIColor.primaryDarkColor()
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(newActivity), for: .touchUpInside)
        btn.setTitle(title: "+", color: UIColor.primaryColor())
        
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
    
    func getService() {
        let code = Defaults[.employee_code]!
        let parameters = ["str_resource_id": code] as [String : Any]
        
        ApiService.sharedInstance.getActivitiesByResourceId(parameters: parameters) { (err, statusCode, json) in
            
            print("before error")
            
            if let error = err {
                print("Error: \(error)")
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
                            self.listActivities = try JSONDecoder().decode([Task].self, from: activities.rawData())
                            self.collectionView?.reloadData()
                            self.stopRefreshControl()
                        }else {
                            print("Actividades vacias")
                            self.stopRefreshControl()
                        }
                    }catch let error {
                        print("no se pudo decodificar",error)
                        self.view.makeToast("Datos incorrectos")
                        self.stopRefreshControl()
                    }
                } else {
                    print("Contenido vacio")
                    self.view.makeToast("No se ha podido cargar los lugares de trabajo")
                    self.stopRefreshControl()
                }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ActiityCell2
        
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                cell.item = self.listActivities[indexPath.row]
        }, completion: nil)
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
            
            let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
            if translation.y >= 0 {
                self.btn_new_activity.transform = CGAffineTransform(translationX: 0, y: 0).concatenating(CGAffineTransform(scaleX: 1, y: 1))
                self.btn_new_activity.alpha = 1
            } else {
                self.btn_new_activity.transform = CGAffineTransform(translationX: 0, y: -100).concatenating(CGAffineTransform(scaleX: 0.5, y: 0.5))
                self.btn_new_activity.alpha = 0
            }
            print("Translation: \(translation)")
            
        }, completion: nil)
    }
    
}
