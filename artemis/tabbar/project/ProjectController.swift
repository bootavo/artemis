//
//  ProjectController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ProjectController: UIViewController, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var project:[ProjectHelper] = {
        
        // Project #1
        var proj1 = ProjectHelper()
        proj1.project_code = "PROY032"
        proj1.project_name = "ARTEMIS"
        proj1.project_status = "A"
        proj1.project_date = "28/05/2018 28/06/2018"
        
        // Project #1
        var proj2 = ProjectHelper()
        proj2.project_code = "PROY033"
        proj2.project_name = "CRM PORTAL"
        proj2.project_status = "A"
        proj2.project_date = "28/05/2018 28/06/2018"
        
        // Project #1
        var proj3 = ProjectHelper()
        proj3.project_code = "PROY034"
        proj3.project_name = "BSCS"
        proj3.project_status = "A"
        proj3.project_date = "28/05/2018 28/06/2018"
        
        return [proj1, proj2, proj3]
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        /*
        self.collectionView?.register(ProjectViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
         */
        
        //self.collectionView?.register(ProjectViewCell.self, forCellWithReuseIdentifier: "cell")
        //self.collectionView?.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        //self.navigationController?.navigationBar.isTranslucent = false // need specificate when general trnasulcent is false
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        
        self.navigationController?.isNavigationBarHidden = false
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Proyectos"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
    }
    
}

extension ProjectController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return project.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProjectViewCell
        cell.project = self.project[indexPath.row]
        
        return cell
    }
    
}
