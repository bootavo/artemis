//
//  AssistanceCell.swift
//  artemis
//
//  Created by VF Consulting on 8/2/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import UIKit

class AssistanceCell: UICollectionViewCell{
    
    var item: AssistenceModel? {
        
        didSet {
            
            if let fecha = item?.fecha {
                let comp = fecha.components(separatedBy: " ")
                self.tv_month.text = comp[2] + comp[1]
                self.tv_day.text = comp[0]
            }
            
            if let vch = item?.vch_nom_ins_tra {
                self.tv_enterprice.text = "\(vch)"
            }
            
            if let cant = item?.cantidad_horas, let inicio = item?.tms_time_ini_acti, let fin = item?.tms_time_fin_acti {
                self.tv_detail.text = "\(cant) (\(inicio) - \(fin))"
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has been not implemented")
    }
    
    let tv_month: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "ABR 30", size: 14)
        text.text = "ABR 30"
        text.textColor = UIColor.black
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_day: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "LUNES", size: 14)
        text.text = "LUNES"
        text.textColor = UIColor.darkGray
        text.textAlignment = .center
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let tv_enterprice: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "ENTEL - SEDE SAN ISIDRO", size: 14)
        text.text = "ENTEL - SEDE SAN ISIDRO"
        text.textColor = UIColor.black
        text.isUserInteractionEnabled = false
        text.textAlignment = .left
        return text
    }()
    
    let tv_detail: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "00:09 hrs. 00 min. (08:26 - 17:26)", size: 14)
        text.text = "00:09 hrs. 00 min. (08:26 - 17:26)"
        text.textColor = UIColor.darkGray
        text.textAlignment = .left
        text.isUserInteractionEnabled = false
        return text
    }()
    
    let iv_icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_assistance_gray")
        return image
    }()
    
    let v_separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    func setupViews(){
        backgroundColor = UIColor.clear
        
        addSubview(tv_month)
        tv_month.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(30).offset(30)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        addSubview(tv_day)
        tv_day.snp.makeConstraints { (make) in
            make.top.equalTo(30).offset(60)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        addSubview(tv_enterprice)
        tv_enterprice.snp.makeConstraints { (make) in
            make.top.equalTo(30).offset(30)
            make.left.equalToSuperview().offset(130)
            make.width.equalTo(240)
            make.height.equalTo(30)
        }
        
        addSubview(iv_icon)
        iv_icon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(30).offset(65)
            make.left.equalToSuperview().offset(130)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        addSubview(tv_detail)
        tv_detail.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(30).offset(60)
            make.left.equalTo(iv_icon).offset(20)
            make.width.equalTo(230)
            make.height.equalTo(30)
        }
        
        addSubview(v_separator)
        v_separator.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(110)
            make.width.equalTo(1)
            make.height.equalTo(110)
        }
        
    }
    
}
