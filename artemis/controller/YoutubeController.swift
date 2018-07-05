//
//  ViewController.swift
//  youtube
//
//  Created by admin on 22/03/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit

class YoutubeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos:[Video] = {
        
        // She will be loved
        var maroon_5_channel = Channel()
        maroon_5_channel.name = "Maroon 5"
        maroon_5_channel.profileImageName = "maroon_5"
        
        var she_will_be_loved = Video()
        she_will_be_loved.title = "Maroon 5 - She will be loved"
        she_will_be_loved.thumbnailImageName = "she_will_be_loved"
        she_will_be_loved.views = "53,452,234"
        she_will_be_loved.channel = maroon_5_channel
        she_will_be_loved.uploadDate = "8 years"
        
        // This love
        var this_love = Video()
        this_love.title = "Maroon 5 - This love"
        this_love.thumbnailImageName = "this_love"
        this_love.views = "35,344,345"
        this_love.channel = maroon_5_channel
        this_love.uploadDate = "6 years"
        
        // Don't look back in anger
        var oasis_channel = Channel()
        oasis_channel.name = "Oasis"
        oasis_channel.profileImageName = "oasis"
        
        var dont_look_back_in_anger = Video()
        dont_look_back_in_anger.title = "Oasis - Don't look back in anger"
        dont_look_back_in_anger.thumbnailImageName = "dont_look_back_in_anger"
        dont_look_back_in_anger.views = "12,244,235"
        dont_look_back_in_anger.channel = oasis_channel
        dont_look_back_in_anger.uploadDate = "6 years"
        
        return [she_will_be_loved, this_love, dont_look_back_in_anger]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [searchBarButtonItem, moreButton]
    }
    
    @objc func handleSearch() {
        print("search")
    }
    
    @objc func handleMore() {
        print("more")
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88) // 68 from Vertical constraints -> was change to 88
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

