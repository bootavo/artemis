//
//  ImageView.swift
//  artemis
//
//  Created by VF Consulting on 7/9/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SnapKit

class ProfileImageView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.primaryColor()
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Components
    
    var imageView: CircularImage = {
        let imgView = CircularImage(image: UIImage())
        return imgView
    }()
    
    //Setup View
    private func setupViews() {
        self.addSubview(imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4.5)
            make.leading.equalToSuperview().offset(4.5)
            make.trailing.equalToSuperview().offset(-4.5)
            make.bottom.equalToSuperview().offset(-4.5)
        }
    }
}

//MARK:-
class CircularImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2.0
    }
    override init(image: UIImage?) {
        super.init(image: image)
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.placeHolder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

