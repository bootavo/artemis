//
//  File.swift
//  youtube
//
//  Created by admin on 22/03/18.
//  Copyright © 2018 GAP GLOBAL SOLUTIONS S.A.C. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var views: String?
    var uploadDate: String?
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
