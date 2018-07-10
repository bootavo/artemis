//
//  CustomCell.swift
//  artemis
//
//  Created by VF Consulting on 7/9/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit

class MyAccountCellRed: UIButton {
    
    enum TypeOfCell {
        case alone
        case first
        case between
        case last
    }
    
    var isButton: Bool = true {
        didSet {
            detailTitle.isHidden = isButton
            detailImageView.isHidden = !isButton
        }
    }
    
    var type: TypeOfCell = .first {
        didSet {
            if type == TypeOfCell.alone {
                self.drawLineOnTop()
                self.drawLineOnBottom()
            }else if type == TypeOfCell.first {
                self.drawLineOnTop()
                self.drawLineForNext()
            }else if type == TypeOfCell.last {
                self.drawLineOnBottom()
            }else {
                self.drawLineForNext()
            }
        }
    }
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor.primaryDarkColor() : UIColor.primaryDarkColor()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor.primaryDarkColor() : UIColor.primaryDarkColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Components
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Mi perfil"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    let detailImageView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "ic_user_gray")  )
        return imgView
    }()
    
    let detailTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.isHidden = true
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    private func drawLineOnTop() {
        let lineOnTop: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.cellPerfil()
            return view
        }()
        
        self.addSubview(lineOnTop)
        lineOnTop.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func drawLineForNext() {
        let lineForNext: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.cellPerfil()
            return view
        }()
        
        addSubview(lineForNext)
        lineForNext.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func drawLineOnBottom() {
        let lineOnBottom: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.cellPerfil()
            return view
        }()
        self.addSubview(lineOnBottom)
        lineOnBottom.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupViews() {
        self.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        self.addSubview(detailTitle)
        detailTitle.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    
    
}

