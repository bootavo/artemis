//
//  ActivityController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ActivityController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var lastContentOffset: CGFloat = 0
    
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
        view.backgroundColor = UIColor.primaryColor()
        
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
            make.right.equalToSuperview().offset(-48)
        }
        self.btn_new_activity.titleLabel?.font = UIFont.systemFont(ofSize: 60.0)
        
        self.view.addSubview(btn_filter)
        btn_filter.snp.makeConstraints{
            (make) -> Void in
            make.width.equalTo(180)
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(marginTopFilter)
            make.centerX.equalToSuperview()
        }
        
        //margin top
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsetsMake(70, 0, 0, 0)
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Actividades"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
    }
    
    var activity:[Activity] = {
        
        // Activity #1
        var activity1 = Activity()
        activity1.id = 1
        activity1.kind_of_activity = "DESARROLLO"
        activity1.activity_hours = "12"
        activity1.activity_minutes = "24"
        activity1.project_code = "PROY032"
        activity1.date = "27/06/2018"
        
        // Activity #2
        var activity2 = Activity()
        activity2.id = 1
        activity2.kind_of_activity = "DESARROLLO"
        activity2.activity_hours = "12"
        activity2.activity_minutes = "24"
        activity2.project_code = "PROY032"
        activity2.date = "27/06/2018"
        
        // Activity #3
        var activity3 = Activity()
        activity3.id = 1
        activity3.kind_of_activity = "DESARROLLO"
        activity3.activity_hours = "12"
        activity3.activity_minutes = "24"
        activity3.project_code = "PROY032"
        activity3.date = "27/06/2018"
        
        var activity4 = Activity()
        activity4.id = 1
        activity4.kind_of_activity = "DESARROLLO"
        activity4.activity_hours = "12"
        activity4.activity_minutes = "24"
        activity4.project_code = "PROY032"
        activity4.date = "27/06/2018"
        
        var activity5 = Activity()
        activity5.id = 1
        activity5.kind_of_activity = "DESARROLLO"
        activity5.activity_hours = "12"
        activity5.activity_minutes = "24"
        activity5.project_code = "PROY032"
        activity5.date = "27/06/2018"
        
        var activity6 = Activity()
        activity6.id = 1
        activity6.kind_of_activity = "DESARROLLO"
        activity6.activity_hours = "12"
        activity6.activity_minutes = "24"
        activity6.project_code = "PROY032"
        activity6.date = "27/06/2018"
        
        return [activity1, activity2, activity3, activity4, activity5, activity6]
        
    }()
    
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
        print("\(translation)")
    }
    
}

extension ActivityController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellActivity", for: indexPath) as! ActivityViewCell
        cell.activity = self.activity[indexPath.row]
        
        return cell
    }
    
}



