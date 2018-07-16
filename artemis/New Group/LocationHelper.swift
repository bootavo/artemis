//
//  LocationHelper.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/12/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationHelper: UIView {
    static func isLocationPermissionGranted() -> Bool
    {
        guard CLLocationManager.locationServicesEnabled() else { return false }
        return [.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())
    }
}

