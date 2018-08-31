//
//  PopUpProject.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

protocol PopUpProjectDelegate {
    func didSelectItemProject(item: Project)
}

class PopUpProject: UIViewController {
    
    //array
    var data:[Project] = []
    
    var selectedIndex = 0
    
    var state = false
    
    var delegate: PopUpProjectDelegate? = nil
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    func getService(){
        
        let code = Defaults[.employee_code]
        let parameters = ["str_resource_id": code!] as [String : Any]
        
        ApiService.sharedInstance.getProjectsByResourceId(parameters: parameters) { (err, statusCode, json) in
            print("before error")
            
            if let error = err {
                print("Error: \(error)")
                return
            }
            
            print("statusCode: \(statusCode)")
            if let json = json {
                let content = json["content"]
                print("Content: \(content)")
                
                if !content.isEmpty {
                    do {
                        print("attributes")
                        
                        let attributes = content["project_teams"]
                        if !attributes.isEmpty {
                            print("Activities: \(attributes)")
                            self.data = try JSONDecoder().decode([Project].self, from: attributes.rawData())
                            self.pickerView.reloadAllComponents()
                        }else {
                            print("Actividades vacias")
                        }
                    }catch let error {
                        print("no se pudo decodificar",error)
                        self.view.makeToast("Datos incorrectos")
                    }
                } else {
                    print("Contenido vacio")
                    self.view.makeToast("No se ha podido cargar los lugares de trabajo")
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getService()
    }
    
    @IBAction func popUpExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func popUpDone(_ sender: Any) {
        
        if (state){
            let item = data[selectedIndex]
            delegate?.didSelectItemProject(item: item)
            self.dismiss(animated: true, completion: nil)
        }else{
            print("else data Niiiiilllllll")
            self.dismiss(animated: true, completion: nil)
        }

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
        state = true;
        return data[row].str_project_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex = row
    }
}
