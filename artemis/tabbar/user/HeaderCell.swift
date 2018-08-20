//
//  HeaderCell.swift
//  artemis
//
//  Created by VF Consulting on 8/08/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class HeaderCell: UICollectionReusableView {
    
    var categoryProject: CategoryProjects? {
        didSet {
            if let categoryName = categoryProject?.category_name {
                print("inside HeaderCell")
                tv_title.text = categoryName
                print("inside HeaderCell")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        print("init HeaderCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been not implemented")
    }
    
    let v_top: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tv_title: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "", size: 14)
        text.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        text.textColor = UIColor.black
        text.textAlignment = .left
        text.isUserInteractionEnabled = false
        text.text = "PROYECTOS EN CURSO"
        text.backgroundColor = UIColor.clear
        return text
    }()
    
    let v_bottom: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        
        backgroundColor = UIColor.navBar()
        
        addSubview(tv_title)
        tv_title.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(10)
            make.left.equalTo(16)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        addSubview(v_top)
        v_top.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(v_bottom)
        v_bottom.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
}

