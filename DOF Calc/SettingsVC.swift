//
//  settingsVC.swift
//  DOF Calc
//
//  Created by Adam Wayland on 12/27/16.
//  Copyright © 2016 Adam Wayland. All rights reserved.
//

import UIKit

protocol settingsModalDelegate {
    func settingsModalDidFinish(controller: SettingsVC, newCoCString: String)
}

class SettingsVC: UIViewController {
    
    var delegate:settingsModalDelegate! = nil

    @IBAction func cocPressed(_ sender: UIButton) {
        delegate.settingsModalDidFinish(controller: self, newCoCString: (sender.titleLabel?.text)!)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
