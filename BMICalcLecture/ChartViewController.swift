//
//  ChartViewController.swift
//  BMICalcLecture
//
//  Created by Jones, Dave on 2/9/16.
//  Copyright © 2016 Jones, Dave. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Read data from logfile
        var xaxis : [String] = []
        var yaxis : [Double] = []
        
        let logFile = FileUtils(fileName: "bmilog.csv")
        if( logFile.fileExists()){
            let rawLogData = logFile.readFile()
            let logEntries : Array = rawLogData.componentsSeparatedByString("\n")
        // Convert the record into a date/time object
        // compare with the startdate and enddate time object
        //  if between - use that record's string
        //  otherwise skip
            for record : String in logEntries {
                //    record is a comma delimited string
                if( record != "" ){
                    let entry : Array = record.componentsSeparatedByString(",")
                    xaxis.append( entry[2] )
                    var yvalue = 0.0
                    if let y = Double(entry[1]){
                        yvalue = y
                    }
                    yaxis.append( yvalue )
                }
            }
            setChart( xaxis, values: yaxis )
        }
 /*     X-AXIS
        let months = [
            "Jan", "Feb", "Mar", "Apr",
            "May", "Jun", "Jul", "Aug",
            "Sep", "Oct", "Nov", "Dec"
        ]
        
        Y-AXIS
        let weightPoints = [
            190.0, 188.0, 187.0, 185.0,
            180.0, 179.0, 178.0, 175.0,
            160.0, 170.0, 175.0, 200.0
        ]
*/
        
      //  setChart( months, values: weightPoints )
    }

    @IBAction func switchToLogger(sender: UIButton) {
        self.performSegueWithIdentifier("fromChartToLogger", sender: self)

    
    }
    
    func setChart( xAxisLabels : [String], values: [Double] ){
        
        barChartView.noDataText = "You must supply some weight data for the bar chart"
        barChartView.noDataTextDescription = "Log some data in the weight logger"
        
        var dataEntries : [BarChartDataEntry] = []
        for i in 0..<xAxisLabels.count {
            dataEntries.append( BarChartDataEntry( value: values[i], xIndex: i ) )
        }
        let chartDataSet = BarChartDataSet( yVals: dataEntries, label: "Weight" )
        let chartData = BarChartData( xVals: xAxisLabels, dataSet: chartDataSet )
        barChartView.data = chartData
        
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
