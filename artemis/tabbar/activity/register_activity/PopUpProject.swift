//
//  PopUpProject.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

protocol PopUpProjectDelegate {
    func didSelectItemProject(item: String)
}

class PopUpProject: UIViewController {
    
    //array
    var data:[Project] = {
        
        // Project #1
        var proj1 = Project()
        proj1.project_code = "PROY032"
        proj1.project_name = "ARTEMIS"
        proj1.project_status = "A"
        proj1.project_date = "28/05/2018 28/06/2018"
        
        // Project #1
        var proj2 = Project()
        proj2.project_code = "PROY033"
        proj2.project_name = "CRM PORTAL"
        proj2.project_status = "A"
        proj2.project_date = "28/05/2018 28/06/2018"
        
        // Project #1
        var proj3 = Project()
        proj3.project_code = "PROY034"
        proj3.project_name = "BSCS"
        proj3.project_status = "A"
        proj3.project_date = "28/05/2018 28/06/2018"
        
        return [proj1, proj2, proj3]
        
    }()
    
    var selectedIndex = 0
    
    var delegate: PopUpProjectDelegate? = nil
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func popUpExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func popUpDone(_ sender: Any) {
        
        let item = data[selectedIndex].project_code
        delegate?.didSelectItemProject(item: item!)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PopUpProject: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].project_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex = row
    }
}
