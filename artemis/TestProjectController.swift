//
//  TestProjectController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class TestProjectController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var project:[Project] = {
        // Project #1
        var proj1 = Project()
        proj1.project_code = "PROY032"
        proj1.project_name = "ARTEMIS"
        proj1.project_status = "A"
        proj1.project_date = "28/05/2018 28/06/2018"
        
        // Project #1
        var proj2 = Project()
        proj2.project_code = "PROY033"
        proj2.project_name = "CRM PORTAL"
        proj2.project_status = "A"
        proj2.project_date = "28/05/2018 28/06/2018"
        
        // Project #1
        var proj3 = Project()
        proj3.project_code = "BSCS"
        proj3.project_name = "ARTEMIS"
        proj3.project_status = "A"
        proj3
            .project_date = "28/05/2018 28/06/2018"
        
        return [proj1, proj2, proj3]
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    self.collectionView?.register(ProjectViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Proyectos"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
        */
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection")
        return project.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProjectViewCell
        
        cell.project = project[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 150)
    }

}
