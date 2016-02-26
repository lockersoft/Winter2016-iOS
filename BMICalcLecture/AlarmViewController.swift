//
//  AlarmViewController.swift
//  BMICalcLectureNOTES
//
//  Created by Jones, Dave on 2/23/16.
//  Copyright © 2016 Jones, Dave. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    @IBOutlet var alarmTime: UITextField!
    @IBOutlet var notesText: UITextView!
    @IBOutlet var recurringSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   registerNotifications()
    }

    @IBAction func setAlarmTime1(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func setDateTimeTextEdit( date : NSDate ){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        alarmTime.text = dateFormatter.stringFromDate(date)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        setDateTimeTextEdit( sender.date)
        sendNotification(sender.date )
    }
    
    func sendNotification( date : NSDate ){
        let notification = UILocalNotification()
        notification.fireDate = date //timeIntervalSinceNow: 10 )
        notification.alertBody = notesText.text //"Yo!  Take your medicine"
        notification.alertAction = "See the medicine reminder."
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = [ "AlarmNumber": "1" ]
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    @IBAction func textFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func registerNotifications(){
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Alert, .Badge, .Sound],
            categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
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
