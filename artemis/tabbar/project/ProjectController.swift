//
//  ProjectController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ProjectController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Proyectos"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
}
