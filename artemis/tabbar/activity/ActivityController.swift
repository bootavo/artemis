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
       
        return [activity1, activity2, activity3]
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Actividades"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
        
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



