//
//  ActivityController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

class ActivityController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var lastContentOffset: CGFloat = 0
    
    var listActivities:[Task] = []
    var items = [Task]()
    
    let btn_new_activity: UIButton = {
        var btn = UIButton()
        btn.frame = CGRect(x: 30, y: 200, width: 50, height: 50)
        btn.backgroundColor = UIColor.primaryDarkColor()
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(newActivity), for: .touchUpInside)
        btn.setTitle(title: "+", color: UIColor.primaryColor())
        return btn
    }()
    
    let btn_filter: RoundedButton = {
        var btn = RoundedButton()
        btn.addTarget(self, action: #selector(newActivity), for: .touchUpInside)
        btn.setTitle(title: "Filtar", color: UIColor.primaryColor())
        return btn
    }()
    
    @objc func newActivity(){
        print("newActivity")
        let dummySettingsViewController = RegisterActivityController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = "Registrar Nueva Actividad"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
        var marginBottom: Float = 0
        var marginTopFilter: Float = 0
        
        let device = DeviceHelper()
        let isIphoneX: Bool = device.isIphoneX()
        
        if isIphoneX {
            marginBottom = -100
            marginTopFilter = 105
        } else {
            marginBottom = -80
            marginTopFilter = 80
        }
        
        self.view.addSubview(btn_new_activity)
        btn_new_activity.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(marginBottom)
            make.right.equalToSuperview().offset(-28)
        }
        self.btn_new_activity.titleLabel?.font = UIFont.systemFont(ofSize: 60.0)
        
        /*self.view.addSubview(btn_filter)
        btn_filter.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(180)
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(marginTopFilter)
            make.centerX.equalToSuperview()
        }*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //margin top
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0) //70 marginTop
        }
        
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        //self.navigationController?.navigationBar.isTranslucent = false // need specificate when general trnasulcent is false
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        
        self.navigationController?.isNavigationBarHidden = false
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Actividades"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
        self.getService()
    }
    
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
                            self.collectionView.reloadData()
                        }else {
                            print("Actividades vacias")
                        }
                    }catch let error {
                        print("no se pudo decodificar",error)
                        self.view.makeToast("Datos incorrectos")
                    }
                } else {
                    print("Contenido vacio")
                    self.view.makeToast("No se ha podido cargar los lugares de trabajo")
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)
        if translation.y >= 0 {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.btn_new_activity.isHidden = false
                self.btn_filter.isHidden = false
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.btn_new_activity.isHidden = true
                self.btn_filter.isHidden = true
            }, completion: nil)
        }
        
        /*
        if (self.lastContentOffset >= scrollView.contentOffset.y) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.btn_new_activity.isHidden = false
                self.btn_filter.isHidden = false
            }, completion: nil)
        } else if (self.lastContentOffset < scrollView.contentOffset.y) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.btn_new_activity.isHidden = true
                self.btn_filter.isHidden = true
            }, completion: nil)
        }
        
        if (self.lastContentOffset <= 0) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.btn_new_activity.isHidden = false
                self.btn_filter.isHidden = false
            }, completion: nil)
        }
        */
        
        //self.lastContentOffset = scrollView.contentOffset.y
        print("Translation: \(translation)")
    }
    
}

extension ActivityController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellActivity", for: indexPath) as! ActivityViewCell
        cell.activity = self.listActivities[indexPath.row]
        
        return cell
    }
    
}



