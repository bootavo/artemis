//
//  AbsentController.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/8/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class ReportController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let employeesCell:String = "listEmployeesCell"
    let absentsCell:String = "listAbsentsCell"
    let latersCell:String = "listAatersCell"
    
    let menuNames = ["ASISTENCIA", "INASISTENCIA", "TADANZAS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        //self.navigationController?.navigationBar.isTranslucent = false // need specificate when general trnasulcent is false
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        
        //CollecitonView tab
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        let bounds = navigationController?.navigationBar.bounds
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (bounds?.width)!, height: (bounds?.height)!))
        titleLabel.text = "Reportes"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
        navigationItem.title = "Reportes"
        
        setupCollectionView()
        setupMenuBar()
    }
    
    lazy var menuBar:ReportMenuBar = {
        let mb = ReportMenuBar()
        mb.homeController = self
        return mb
    }()
    
    func setupCollectionView(){
        collectionView?.backgroundColor = UIColor.clear
        
        collectionView?.register(ListEmployeesCell.self, forCellWithReuseIdentifier: employeesCell)
        collectionView?.register(ListAbsentsCell.self, forCellWithReuseIdentifier: absentsCell)
        collectionView?.register(ListLatersCell.self, forCellWithReuseIdentifier: latersCell)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    private func setupMenuBar(){
        //HideNavigationBar when scroll down
        //navigationController?.hidesBarsOnSwipe = false
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        //Setup Menu Bar
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        //HideNavigationBar when scroll down
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func nextActivity(employee: Employee){
        //let detailEmployeeHistoryController = UIViewController()
        //navigationController?.pushViewController(detailEmployeeHistoryController, animated: true)
        let layout = UICollectionViewFlowLayout()
        let employeepDetailHistoryController = EmployeeDetailHistoryController(collectionViewLayout: layout)
        employeepDetailHistoryController.employee = employee
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(employeepDetailHistoryController, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.move().x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    //Function used in ReportMenuBar
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: employeesCell, for: indexPath) as! ListEmployeesCell
            cell.contentView.isUserInteractionEnabled = false
            cell.reportController = self
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: absentsCell, for: indexPath) as! ListAbsentsCell
            cell.contentView.isUserInteractionEnabled = false
            return cell
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: latersCell, for: indexPath) as! ListLatersCell
            cell.contentView.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: employeesCell, for: indexPath) as! ListEmployeesCell
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50) //50
    }
    
}
