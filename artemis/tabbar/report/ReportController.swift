//
//  AbsentController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ReportController: UIViewController, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Reportes"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.tabBarController?.navigationItem.titleView = titleLabel
    }
    
    var kind_of_report:[KindOfReport] = {
        
        // Report #1
        var laters = KindOfReport()
        laters.id = 1
        laters.title = "Tardanza"
        laters.desc = "Permite visualizar las tardanzas según la fecha solicitada"
        laters.photo = "ic_kind_of_project"
        
        
        // Report #2
        var absents = KindOfReport()
        absents.id = 1
        absents.title = "Inasistencia"
        absents.desc = "Permite visualizar la inasistencia según la fecha solicitada"
        absents.photo = "ic_kind_of_project"
        
        // Report #3
        var assistances = KindOfReport()
        assistances.id = 1
        assistances.title = "Asistencia"
        assistances.desc = "Permite visualizar la asistencia en el mes de cada trabajador"
        assistances.photo = "ic_kind_of_project"
        
        return [laters, absents, assistances]
        
    }()
    
}

extension ReportController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kind_of_report.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReport", for: indexPath) as! ReportCell
        cell.kind_of_report = self.kind_of_report[indexPath.row]
        
        return cell
    }
    
}
