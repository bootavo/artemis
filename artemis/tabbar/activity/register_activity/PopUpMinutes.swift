//
//  PopUpTime.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

protocol PopUpMinutesDelegate {
    func didSelectMinutes(item: String)
}

class PopUpMinutes: UIViewController {
    
    //array
    var data: [String] = {
        return ["01","05","10","15","20","25","30","35","40","45","50","55"]
    }()
    
    var selectedIndex = 0
    
    var delegate: PopUpMinutesDelegate? = nil
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popUpExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func popUpDone(_ sender: Any) {
        let item = data[selectedIndex]
        delegate?.didSelectMinutes(item: item)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PopUpMinutes: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex = row
    }
}



