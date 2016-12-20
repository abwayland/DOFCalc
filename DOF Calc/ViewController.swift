//
//  ViewController.swift
//  DOF Calc
//
//  Created by Adam Wayland on 12/20/16.
//  Copyright © 2016 Adam Wayland. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.35, alpha: 1)
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var totalDOFView: UILabel!
    @IBOutlet var nearPointView: UILabel!
    @IBOutlet var farPointView: UILabel!
    @IBOutlet var fStopButton: UIButton!
    @IBOutlet var focalLengthButton: UIButton!
    @IBOutlet var distanceButton: UIButton!
    
    //MARK: Button Actions
    
    var isSomeButtonSelected = false
    
    func someButtonIsPressed(_ sender: UIButton) {
        isSomeButtonSelected = !isSomeButtonSelected
        for subView in self.view.subviews {
            if subView.tag == 99 {
                subView.isHidden = !subView.isHidden
            }
        }
        pickerView.isHidden = !pickerView.isHidden
    }
    
    @IBAction func fStopButtonPressed(_ sender: UIButton) {
        someButtonIsPressed(sender)
        if isSomeButtonSelected {
            self.view.backgroundColor = sender.backgroundColor
            fStopButton.setTitle("close", for: .normal)
        } else {
            self.view.backgroundColor = backgroundColor
            fStopButton.setTitle("f/" + String(fStopArr[pickerView.selectedRow(inComponent: 0)]), for: .normal)
        }
    }
    
    @IBAction func focalLengthButtonPressed(_ sender: UIButton) {
        someButtonIsPressed(sender)
    }
    
    @IBAction func distanceButtonPressed(_ sender: UIButton) {
        print("distance")
        self.view.backgroundColor = sender.backgroundColor
        distanceButton.setTitle("close", for: .normal)
    }
    
    //MARK: pickerView Delegates and DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fStopArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(fStopArr[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //fStopButton.setTitle(String(fStopArr[row]), for: .normal)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: String(fStopArr[row]), attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }
    
    let fStopArr = [1.0, 1.1, 1.2, 1.4, 1.6, 1.8, 2.0, 2.5, 2.8, 3.2, 3.5, 4.0, 4.5, 5.0, 5.6, 6.3, 7.1, 8.0, 9.0, 10, 11, 13, 14, 16, 18, 20, 22]
    
    let focalLengthArr = [14, 17, 20, 24, 35, 40, 50, 70, 85, 105, 135, 200, 250, 300]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.backgroundColor = backgroundColor
        fStopButton.setTitle(String(fStopArr[0]), for: .normal)
        focalLengthButton.setTitle(String(focalLengthArr[0]), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

