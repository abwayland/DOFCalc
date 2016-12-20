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
    
    func someButtonIsPressed() {
        isSomeButtonSelected = !isSomeButtonSelected
        for subView in self.view.subviews {
            if subView.tag == 99 {
                subView.isHidden = !subView.isHidden
            }
        }
        pickerView.isHidden = !pickerView.isHidden
    }
    
    var nameOfButtonPressed = ""
    
    @IBAction func fStopButtonPressed(_ sender: UIButton) {
        someButtonIsPressed()
        nameOfButtonPressed = "fStop"
        if isSomeButtonSelected {
            self.view.backgroundColor = sender.backgroundColor
            fStopButton.setTitle("close", for: .normal)
            pickerView.reloadAllComponents()
        } else {
            self.view.backgroundColor = backgroundColor
            fStopButton.setTitle("f/" + String(fStopArr[pickerView.selectedRow(inComponent: 0)]), for: .normal)
        }
    }
    
    @IBAction func focalLengthButtonPressed(_ sender: UIButton) {
        someButtonIsPressed()
        nameOfButtonPressed = "focalLength"
        if isSomeButtonSelected {
            self.view.backgroundColor = sender.backgroundColor
            focalLengthButton.setTitle("close", for: .normal)
            pickerView.reloadAllComponents()
        } else {
            self.view.backgroundColor = backgroundColor
            focalLengthButton.setTitle(String(focalLengthArr[pickerView.selectedRow(inComponent: 0)]) + "mm", for: .normal)
        }
    }
    
    @IBAction func distanceButtonPressed(_ sender: UIButton) {
        someButtonIsPressed()
        nameOfButtonPressed = "distance"
        if isSomeButtonSelected {
            self.view.backgroundColor = sender.backgroundColor
            distanceButton.setTitle("close", for: .normal)
            pickerView.reloadAllComponents()
        } else {
            self.view.backgroundColor = backgroundColor
            distanceButton.setTitle(String(distanceArr[pickerView.selectedRow(inComponent: 0)]) + "ft", for: .normal)
        }
    }
    
    //MARK: pickerView Delegates and DataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch nameOfButtonPressed {
        case "fStop":
            return fStopArr.count
        case "focalLength" :
            return focalLengthArr.count
        case "distance" :
            return distanceArr.count
        default:
            return fStopArr.count
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch nameOfButtonPressed {
        case "fStop":
            print("fstop")
            return String(fStopArr[row])
        case "focalLength" :
            print("focalLength")
            return String(focalLengthArr[row])
        case "distance" :
            print("distance")
            return String(distanceArr[row])
        default:
            print("default")
            return String(fStopArr[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //fStopButton.setTitle(String(fStopArr[row]), for: .normal)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        switch nameOfButtonPressed {
        case "fStop":
            print("fstop")
            return NSAttributedString(string: String(fStopArr[row]), attributes: [NSForegroundColorAttributeName : UIColor.white])
        case "focalLength" :
            print("focalLength")
            return NSAttributedString(string: String(focalLengthArr[row]) + "mm", attributes: [NSForegroundColorAttributeName : UIColor.white])
        case "distance" :
            print("distance")
            return NSAttributedString(string: String(distanceArr[row]), attributes: [NSForegroundColorAttributeName : UIColor.white])
        default:
            print("default")
            return NSAttributedString(string: String(fStopArr[row]), attributes: [NSForegroundColorAttributeName : UIColor.white])
        }
    }
    
    let fStopArr = [1.0, 1.1, 1.2, 1.4, 1.6, 1.8, 2.0, 2.5, 2.8, 3.2, 3.5, 4.0, 4.5, 5.0, 5.6, 6.3, 7.1, 8.0, 9.0, 10, 11, 13, 14, 16, 18, 20, 22]
    
    let focalLengthArr = [14, 17, 20, 24, 35, 40, 50, 70, 85, 105, 135, 200, 250, 300]
    
    let distanceArr = [1 ,5 ,10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.backgroundColor = backgroundColor
        fStopButton.setTitle(String(fStopArr[0]), for: .normal)
        focalLengthButton.setTitle(String(focalLengthArr[0]), for: .normal)
        distanceButton.setTitle(String(distanceArr[0]), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

