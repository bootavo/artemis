//
//  AssistanceMain.swift
//  artemis
//
//  Created by VF Consulting on 7/17/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit

class AssistanceController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let registerCell = "registerCell"
    let assistanceHistoryCell = "assistanceHistoryCell"
    
    let menuNames = ["MARCAR", "HISTORIAL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
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
        titleLabel.text = "Asistencia"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if collectionView != nil {
            collectionView!.collectionViewLayout.invalidateLayout()
            collectionView!.reloadData()
        }
        
    }
    
    lazy var menuBar: AssistanceMenuBar = {
        let mb = AssistanceMenuBar()
        mb.homeController = self
        return mb
    }()
    
    func setupCollectionView(){
        collectionView?.backgroundColor = UIColor.clear
        
        collectionView?.register(RegisterAssistanceCell.self, forCellWithReuseIdentifier: registerCell)
        collectionView?.register(AssistanceHistoryCell.self, forCellWithReuseIdentifier: assistanceHistoryCell)
        
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 2
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.move().x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    //Function used in AssistanceMenuBar
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var identifier: String
        if indexPath.item == 0 {
            identifier = registerCell
        } else if indexPath.item == 1 {
            identifier = assistanceHistoryCell
        } else {
            identifier = registerCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50) //50
    }
    
}

