//
//  PopUpProject.swift
//  artemis
//
//  Created by Gustavo Tufiño Fernandez on 7/13/18.
//  Copyright © 2018 GTUFINOF. All rights reserved.
//

import UIKit

protocol PopUpKindOfActivityDelegate {
    func didSelectItemKindOfActivity(item: KindOfActivity)
}

class PopUpKindOfActivity: UIViewController {
    
    //array
    var data:[KindOfActivity] = []
    
    var selectedIndex = 0
    
    var delegate: PopUpKindOfActivityDelegate? = nil
    
    //Catch parameter id of project
    var projectId = Int()
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    func getService(){
        let parameters = ["num_project_id": projectId] as [String : Any]

        ApiService.sharedInstance.getKindOfActivities(parameters: parameters) { (err, statusCode, json) in
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
                        
                        let attributes = content["tasks"]
                        if !attributes.isEmpty {
                            print("Tasks: \(attributes)")
                            self.data = try JSONDecoder().decode([KindOfActivity].self, from: attributes.rawData())
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
        print("PopUpKindOFActivity Id capturado: \(projectId)")
        getService()
    }
    
    @IBAction func popUpExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func popUpDone(_ sender: Any) {
        let item = data[selectedIndex]
        delegate?.didSelectItemKindOfActivity(item: item)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PopUpKindOfActivity: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].str_taskname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex = row
    }
}
