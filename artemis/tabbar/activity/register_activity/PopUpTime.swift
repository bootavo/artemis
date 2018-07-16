//
//  PopUpTime.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

protocol PopUpTimeDelegate {
    func didSelectItem(item: String)
}

class PopUpTime: UIViewController {
    
    //array
    var data: [String] = {
        return ["1","2","3"]
    }()
    
    var selectedIndex = 0
    
    var delegate: PopUpTimeDelegate? = nil
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func popUpExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func popUpDone(_ sender: Any) {
        
        let item = data[selectedIndex]
        delegate?.didSelectItem(item: item)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PopUpTime: UIPickerViewDataSource, UIPickerViewDelegate {
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



