//
//  WeightLogViewController.swift
//  BMICalcLecture
//
//  Created by Jones, Dave on 2/2/16.
//  Copyright © 2016 Jones, Dave. All rights reserved.
//

import UIKit

class WeightLogViewController: UIViewController {


    @IBOutlet weak var txtBMI: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    
    var IncomingBMI : String = ""
    var IncomingWeight : String = ""
    let logFile = FileUtils(fileName: "bmilog.csv")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtWeight.text = IncomingWeight
        txtBMI.text = IncomingBMI
        setDateTimeTextEdit( NSDate() )
    }
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func setDateTimeTextEdit( date : NSDate ){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        txtDate.text = dateFormatter.stringFromDate(date)
        
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        txtTime.text = dateFormatter.stringFromDate(date)

    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        setDateTimeTextEdit( sender.date)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func switchToChart(sender: AnyObject) {
        self.performSegueWithIdentifier("SwitchToChart", sender: self)
        
    }
    
    @IBAction func clearLogFile(sender: UIButton) {
        logFile.clearFile()
    }
    
    @IBAction func saveData(sender: UIButton) {
        print("Saving Log Data ...")
        let logEntry = "\(txtBMI.text!),\(txtWeight.text!),\(txtDate.text!),\(txtTime.text!)\n"
        print( logEntry )
        let retVal = logFile.appendFile(logEntry)
        print("Entire File: \n" )
        print(logFile.readFile())
        
        print( retVal ?  "File Saved":
            "File Error")
       
    }
    

    @IBAction func switchToCalc(sender: UIButton) {
        self.performSegueWithIdentifier("switchToCalc", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
