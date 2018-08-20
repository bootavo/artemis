//
//  RefreshControlHelper.swift
//  artemis
//
//  Created by VF Consulting on 6/08/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class RefreshControlHelper {
    
    var collectionView: UICollectionView?
    var refreshControl: UIRefreshControl?
    var view: UIView?
    
    var refreshAction: (() -> Void)?
    
    required init(v: UIView, cv: UICollectionView, rc: UIRefreshControl) {
        self.view = v
        self.collectionView = cv
        self.refreshControl = rc
        setupRefreshControl()
    }
    
    func setupRefreshControl(){
        collectionView?.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl?.tintColor = UIColor.primaryDarkColor()
        
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.primaryDarkColor()]
        refreshControl?.attributedTitle = NSAttributedString(string: "Cargando ...", attributes: attributes)
    }
    
    func showRefreshControl(){
        self.refreshControl?.tintColor = UIColor.primaryDarkColor()
        self.refreshControl?.beginRefreshing()
        self.collectionView?.setContentOffset(CGPoint(x: 0, y: (collectionView?.contentOffset.y)! - (refreshControl?.frame.size.height)!), animated: true)
    }
    
    func stopRefreshControl(){
        self.refreshControl?.endRefreshing()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        refreshAction?()
    }
    
}
