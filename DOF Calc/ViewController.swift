//
//  ViewController.swift
//  DOF Calc
//
//  Created by Adam Wayland on 12/20/16.
//  Copyright © 2016 Adam Wayland. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var backgroundColor: UIColor? = nil
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var totalDOFView: UILabel!
    @IBOutlet var nearPointView: UILabel!
    @IBOutlet var farPointView: UILabel!
    @IBOutlet var fStopButton: UIButton!
    @IBOutlet var focalLengthButton: UIButton!
    @IBOutlet var distanceButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    @IBOutlet var hyperFocalView: UILabel!
    var fStop: Double = 1.0
    var fStopIdx = 0
    var focalLength = 14
    var focalLengthIdx = 0
    var distance = 1
    var distanceIdx = 0
    var totalDOF: Double {
        get{
            return fStop * Double(focalLength)
        }
    }
    
    @IBAction func settingsModalDidFinishWithFourThirds(segue: UIStoryboardSegue) {
        CoC = CoC_fourThirds
        settingsButton.setTitle("4/3", for: .normal)
        updateValuesInViews()
    }
    
    @IBAction func settingsModalDidFinishWithAPS_C(segue: UIStoryboardSegue) {
        CoC = CoC_APS_C
        settingsButton.setTitle("aps-c", for: .normal)
        updateValuesInViews()
    }
    
    @IBAction func settingsModalDidFinishWith35mms(segue: UIStoryboardSegue) {
        CoC = CoC_35mm
        settingsButton.setTitle("35mm", for: .normal)
        updateValuesInViews()
    }
    
    //Circle of Confusion for various sensors in Millimeters
    var CoC: Double? = nil
    let CoC_fourThirds = 0.014
    let CoC_APS_C = 0.0185
    let CoC_35mm = 0.029
    
    //hyperFocal in Millimeters
    var hyperFocal: Double {
        get {
            if CoC != nil {
                return Double(focalLength * focalLength) / (fStop * CoC!)
            } else {
                return 0.0
            }
            
        }
    }
    
    var nearPoint: Double {
        get {
            return (hyperFocal * Double(convertInToMM(inches: distance))) / (hyperFocal + (convertInToMM(inches: distance) - Double(focalLength)))
        }
    }
    
    var farPoint: Double {
        get {
            return (hyperFocal * Double(convertInToMM(inches: distance))) / (hyperFocal - (convertInToMM(inches: distance) - Double(focalLength)))
        }
    }
    
    var DOF: Double {
        get {
            return farPoint - nearPoint
        }
    }
    
    func convertMMToFt(mm: Double) -> Double {
        return mm / 304.8
    }
    
    func convertInToMM(inches: Int) -> Double {
        return 25.4 * Double(inches)
    }
    
    //MARK: Button Actions
    
    var nameOfButtonPressed = ""
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if nameOfButtonPressed != "fStop" {
                nameOfButtonPressed = "fStop"
                fStopButton.setTitle("close", for: .normal)
                self.view.backgroundColor = sender.backgroundColor
                for subView in self.view.subviews {
                    if subView.tag == 99 {
                        subView.isHidden = true
                    }
                }
                pickerView.reloadAllComponents()
                pickerView.isHidden = false
                pickerView.selectRow(fStopIdx, inComponent: 0, animated: false)
            } else {
                nameOfButtonPressed = ""
                self.view.backgroundColor = backgroundColor
                fStopButton.setTitle("f/" + String(fStop), for: .normal)
                for subView in self.view.subviews {
                    if subView.tag == 99 {
                        subView.isHidden = false
                    }
                }
                pickerView.isHidden = true
            }
            focalLengthButton.setTitle(String(focalLength) + "mm", for: .normal)
            distanceButton.setTitle(getDistString(inches: distance), for: .normal)
        case 2:
            if nameOfButtonPressed != "focalLength" {
                nameOfButtonPressed = "focalLength"
                focalLengthButton.setTitle("close", for: .normal)
                self.view.backgroundColor = sender.backgroundColor
                for subView in self.view.subviews {
                    if subView.tag == 99 {
                        subView.isHidden = true
                    }
                }
                pickerView.reloadAllComponents()
                pickerView.isHidden = false
                pickerView.selectRow(focalLengthIdx, inComponent: 0, animated: false)
            } else {
                nameOfButtonPressed = ""
                self.view.backgroundColor = backgroundColor
                focalLengthButton.setTitle(String(focalLength) + "mm", for: .normal)
                for subView in self.view.subviews {
                    if subView.tag == 99 {
                        subView.isHidden = false
                    }
                }
                pickerView.isHidden = true
            }
            fStopButton.setTitle("f/" + String(fStop), for: .normal)
            distanceButton.setTitle(getDistString(inches: distance), for: .normal)
        case 3:
            if nameOfButtonPressed != "distance" {
                nameOfButtonPressed = "distance"
                distanceButton.setTitle("close", for: .normal)
                self.view.backgroundColor = sender.backgroundColor
                for subView in self.view.subviews {
                    if subView.tag == 99 {
                        subView.isHidden = true
                    }
                }
                pickerView.reloadAllComponents()
                pickerView.isHidden = false
                pickerView.selectRow(distanceIdx, inComponent: 0, animated: false)
            } else {
                nameOfButtonPressed = ""
                self.view.backgroundColor = backgroundColor
                distanceButton.setTitle(getDistString(inches: distance), for: .normal)
                for subView in self.view.subviews {
                    if subView.tag == 99 {
                        subView.isHidden = false
                    }
                }
                pickerView.isHidden = true
            }
            fStopButton.setTitle("f/" + String(fStop), for: .normal)
            focalLengthButton.setTitle(String(focalLength) + "mm", for: .normal)
        default: print("error: button pressed not found")
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
            return String(fStopArr[row])
        case "focalLength" :
            return String(focalLengthArr[row])
        case "distance" :
            return String(distanceArr[row])
        default:
            return String(fStopArr[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch nameOfButtonPressed {
        case "fStop":
            fStop = fStopArr[row]
            fStopIdx = pickerView.selectedRow(inComponent: 0)
        case "focalLength" :
            focalLength = focalLengthArr[row]
            focalLengthIdx = pickerView.selectedRow(inComponent: 0)
        case "distance" :
            distance = distanceArr[row]
            distanceIdx = pickerView.selectedRow(inComponent: 0)
        default: break
        }
        updateValuesInViews()
    }
    
    func updateValuesInViews() {
        let hyperFocalStr = String(format: "%.2fft", convertMMToFt(mm: hyperFocal))
        hyperFocalView.text = hyperFocalStr
        nearPointView.text = String(format: "%.2fft", convertMMToFt(mm: nearPoint))
        if farPoint >= 0 {
            farPointView.text = String(format: "%.2fft", convertMMToFt(mm: farPoint))
        } else {
            farPointView.text = "\u{221E}"
        }
        if DOF >= 0 {
            totalDOFView.text = String(format: "%.2f", convertMMToFt(mm: DOF))
        } else {
            if farPoint - nearPoint < 0.01 && farPoint > 0.0 {
                totalDOFView.text = "0.00"
            } else {
                totalDOFView.text = "\u{221E}"
            }
        }
        self.view.setNeedsDisplay()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        switch nameOfButtonPressed {
        case "fStop":
            return NSAttributedString(string: "f/" + String(fStopArr[row]), attributes: [NSForegroundColorAttributeName : UIColor.white])
        case "focalLength" :
            return NSAttributedString(string: String(focalLengthArr[row]) + "mm", attributes: [NSForegroundColorAttributeName : UIColor.white])
        case "distance" :
            let distPickerStr = getDistString(inches: distanceArr[row])
            return NSAttributedString(string: distPickerStr, attributes: [NSForegroundColorAttributeName : UIColor.white])
        default:
            return NSAttributedString(string: "Error", attributes: [NSForegroundColorAttributeName : UIColor.white])
        }
    }
    
    func getDistString(inches: Int) -> String {
        var distTempStr = ""
        if inches <= 11 {
            distTempStr = String(inches) + "in"
        } else {
            distTempStr = String(Double(inches) / 12.0) + "ft"
        }
        return distTempStr
    }
    
    let fStopArr = [1.0, 1.1, 1.2, 1.4, 1.6, 1.8, 2.0, 2.5, 2.8, 3.2, 3.5, 4.0, 4.5, 5.0, 5.6, 6.3, 7.1, 8.0, 9.0, 10, 11, 13, 14, 16, 18, 20, 22]
    
    let focalLengthArr = [14, 17, 20, 24, 35, 40, 50, 70, 85, 105, 135, 200, 250, 300]
    
    let distanceArr = [1,2,3,4,5,6,7,8,9,10,11,12,18,24,30,36,42,48,54,60,66,72,78,84,90,96,102,108,114,120,132,144,156,168,180,192,204,216,228,240,300,360,420,540,600]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        //settingsButton.setTitle("\u{26ED}", for: .normal)
        fStopButton.setTitle("f/" + String(fStop), for: .normal)
        focalLengthButton.setTitle(String(focalLength) + "mm", for: .normal)
        distanceButton.setTitle(getDistString(inches: distance), for: .normal)
        CoC = CoC_35mm
        settingsButton.setTitle("35mm", for: .normal)
        backgroundColor = self.view.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

