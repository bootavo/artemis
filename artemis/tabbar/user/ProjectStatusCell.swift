//
//  ProjectStatusCell.swift
//  artemis
//
//  Created by VF Consulting on 8/08/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class ProjectStatusCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var categoryProjects: CategoryProjects? {
        
        didSet {
            collectionView.reloadData()
            print("inside ProjectStatusCell")
            
            print("\(categoryProjects!.category_name!)")
            
            print("out ProjectStatusCell")
        }
    }
    
    var projetViewCell = "projetViewCell"
    var headerId = "headerId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("------------------------------> ProjectStatusCell <------------------------------")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    func setupViews(){
        print("--------- > setupViews()")
        backgroundColor = UIColor.clear
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        
        addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ProjectViewCell.self, forCellWithReuseIdentifier: projetViewCell)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView.alwaysBounceVertical = false
        collectionView.bounces = false
        collectionView.flashScrollIndicators()
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        print("--------- > /setupViews()")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("--------- > numberOfItemsInSection()")
        print("ProjectSatusCell count: \(categoryProjects?.projects?.count)")
        
        if let count = categoryProjects?.projects?.count {
            print("projectStatusCell count: \(count)")
            
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
            return count
        }
        print("--------- > /numberOfItemsInSection()")
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("--------- > cellForItemAt()")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projetViewCell, for: indexPath) as! ProjectViewCell
        cell.item = categoryProjects?.projects?[indexPath.item]
        print("--------- > /cellForItemAt()")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        header.categoryProject = categoryProjects
        
        print("Category name xdddd: \(header.categoryProject?.category_name)")
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
}
