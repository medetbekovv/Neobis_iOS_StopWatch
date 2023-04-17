//
//  ViewController.swift
//  “Neobis_iOS_StopWatch”
//
//  Created by user on 15/4/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource {
  
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer = Timer()
    var timeNumber = 0
    var timerCount = false
    
    var startPress = false
    var stopWatch = false
    
    var hour = Array(0...23)
    var minute = Array(0...59)
    var second = Array(0...59)
    
    
//MARK: Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isHidden = true
        
    }

//MARK: Action Button
    
    
    @IBAction func segmentAction(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 1 {
            pickerView.isHidden = false
            stopWatch = true
        } else {
            pickerView.isHidden = false
            stopWatch = false
        }
        
    }
    
    @IBAction func startAction(_ sender: Any) {
        if timerCount == false {
            timerCount = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func stopAction(_ sender: Any) {
        if timerCount == true {
            timer.invalidate()
            timerCount = false
        }
    }
    
    @IBAction func resetAction(_ sender: Any) {
        timer.invalidate()
        timerCount = false
        timeLabel.text = "00:00:00"
        timeNumber = 0
    }
    
    @objc func timerCounter() -> Void {
        if stopWatch == false {
            timeNumber += 1
        } else if stopWatch == true {
            if timeNumber > 0 {
                timeNumber -= 1
            } else {
                timer.invalidate()
                timerCount = false
            }
        }
        let time = secondsToHoursMinutesSeconds(seconds: timeNumber)
        let timerString = makeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeLabel.text = timerString
}
    
    
  
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    
    
    func makeString(hours: Int, minutes: Int, seconds : Int) -> String {
                 
     var timeString = ""
     timeString += String(format: "%02d", hours)
     timeString += ":"
     timeString += String(format: "%02d", minutes)
     timeString += ":"
     timeString += String(format: "%02d", seconds)
                 
     return timeString
    }
    
    

    
   
    
  
    
    //MARK: Extension UIPicker
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return hour.count
        case 1: return minute.count
        case 2: return second.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(format: "%02d", hour[row])
        case 1:
            return String(format: "%02d", minute[row])
        case 2:
            return String(format: "%02d", second[row])
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectHours = hour[pickerView.selectedRow(inComponent: 0)]
        let selectMinuts = minute[pickerView.selectedRow(inComponent: 1)]
        let selectSeconds = second[pickerView.selectedRow(inComponent: 2)]
        timeNumber = (selectHours * 3600) + (selectMinuts * 60) + selectSeconds
        let timeString = makeString(hours: selectHours, minutes: selectMinuts, seconds: selectSeconds)
        timeLabel.text = timeString
        
    }
    
    
   
  
    

    
}

