//
//  MenuBar.swift
//  artemis
//
//  Created by VF Consulting on 7/10/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

class MenuBar:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: AssistanceMain?
    
    //Cells
    let cellId = "cellid"
    let menuNames = ["MARCAR", "HISTORIAL"]
    
    //Creación del CollectionView
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.navBar()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Registro del CollectionView
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        //Restricciones del CollectionView
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        //Iniciar la app con el Home activado
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
        setupHorizontalBar()
    }
    
    var horizontalBarLeftAnchorConstraint : NSLayoutConstraint?
    func setupHorizontalBar(){
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.primaryDarkColor()
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Items del CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    //Items dinamicos del CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        //cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.title.text = menuNames[indexPath.item]
        
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        
        return cell
    }
    
    //Tamaño de los CellViews
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height)
    }
    
    //Quitar espacios y fix position del CollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
}

class MenuCell: BaseCell {
    
    //ImageView que se repite en los CellViews del CollectionView
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    let title : UILabel = {
        let tv = UILabel()
        tv.text = "MARCAR"
        tv.textColor = UIColor.title()
        tv.highlightedTextColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        tv.backgroundColor = UIColor.navBar()
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    let lineView : UIView = {
        var lv = UIView(frame: CGRect(x: 0, y: 100, width: 320, height: 1.0))
        lv.layer.borderWidth = 0.5
        lv.layer.borderColor = UIColor.gray.cgColor
        return lv
    }()
    
    //Detectar el cambio de iconos
    override var isHighlighted: Bool {
        didSet {
            title.highlightedTextColor = isHighlighted ? UIColor.primaryDarkColor() : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    //Cambiar de icono al seleccionarlos
    override var isSelected: Bool {
        didSet {
            title.highlightedTextColor = isSelected ? UIColor.primaryDarkColor() : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        //backgroundColor = UIColor.yellow
        
        //Agregando Subvies al CollectionView
        addSubview(title)
        addConstraintsWithFormat(format: "H:[v0(90)]", views: title)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: title)
        
        //Agregando Restricciones a los items del CollecitonView
        
        //Restricciones Horizontales
        addConstraint(NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        //Restricciones Verticales
        addConstraint(NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(lineView)
        lineView.snp.makeConstraints{
            (make) -> Void in
            make.width.equalToSuperview()
            make.bottom.equalTo(title.snp.bottom).offset(11)
            make.height.equalTo(0.5)
        }
        
    }
    
}

