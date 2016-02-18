//
//  ViewController.swift
//  BMICalcLecture
//
//  Created by Jones, Dave on 1/26/16.
//  Copyright © 2016 Jones, Dave. All rights reserved.
//
//ARC - Automatic Reference Counting

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtWeight: UITextField!
    @IBOutlet var txtHeight: UITextField!
    
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var labelBMI: UILabel!
    
    var american = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblStatus.text = ""
    }

    @IBAction func heightDidEndEditing(sender: UITextField) {
        print("Height done editing")
    }
    
    @IBAction func weightDidEndEditing(sender: UITextField) {
        print("Weight done editing")
   }
    
    @IBAction func changeLocation(sender: UISegmentedControl) {
        print( sender.selectedSegmentIndex )
        if( sender.selectedSegmentIndex == 0 ){
            american = false
        } else {
            american = true
        }
        calculateBMI()
    }
    

    
    @IBAction func calculateBMI( ) {
        var weight = 0.0
        var height = 0.0
        if let h = Double(txtHeight.text!){
            height = h
        }
        if let w = Double(txtWeight.text!) {
            weight = w
        }
        
        if( american ){
            weight += 20
        }
        
        var bmiCalc = (weight * 703) / (height * height)
        if( bmiCalc.isNaN ){
            bmiCalc = 0.0
        }
        labelBMI.text = String(format: "%.2f", bmiCalc)
        let status = getBMIstatus(bmiCalc)
        lblStatus.text = status
    }
    
    func getBMIstatus( bmi:Double ) -> String {
        var status = ""
        
        if( bmi < 16.0){
            status = "Severely Underweight"
        } else if( bmi < 18.0 ){
            status = "Underweight"
        } else if( bmi < 22 ){
            status = "Normal"
        } else if( bmi < 26 ){
            status = "Overweight"
        } else {
            status = "Severely Overweight"
        }
        
        return status
    }
    
    @IBAction func switchToLogger(sender: UIButton) {
        self.performSegueWithIdentifier("SwitchToLog", sender: self)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print( "Inside segue prepare" )
        let WeightLogController = segue.destinationViewController as! WeightLogViewController
        
        WeightLogController.IncomingBMI = labelBMI.text!
        WeightLogController.IncomingWeight = txtWeight.text!
        
        
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

