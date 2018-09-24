//
//  MFMailComposeView.swift
//  artemis
//
//  Created by VF Consulting on 24/09/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import MessageUI

extension MFMailComposeViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
}
