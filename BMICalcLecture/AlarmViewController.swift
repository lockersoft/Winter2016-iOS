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
    @IBOutlet var notesText: UITextField!
    @IBOutlet var recurringSwitch: UISwitch!
    @IBOutlet var switchActive: UISwitch!
    
    @IBOutlet var notesText2: UITextField!
    @IBOutlet var alarmTime2: UITextField!
    @IBOutlet var switchActive2: UISwitch!
    @IBOutlet var recurringSwitch2: UISwitch!
    
    var alarms : Array<Alarm> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   registerNotifications()
        alarms.append( Alarm(alarmTime: alarmTime, notesText: notesText, recurring: recurringSwitch, active: switchActive))
        alarms.append( Alarm(alarmTime: alarmTime2, notesText: notesText2, recurring: recurringSwitch2, active: switchActive2))
    }

    @IBAction func setAlarmTime1(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        print("Tag: \(sender.tag)")
        datePickerView.tag = sender.tag
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func activateAlarm(sender: UISwitch) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle

        if( sender.on ){
            let alarmDate = dateFormatter.dateFromString(alarms[sender.tag].alarmTime.text! )
          sendNotification(alarmDate!, tag: sender.tag )
        }
    }
    
    
    func setDateTimeTextEdit( date : NSDate, tag : Int ){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        alarms[tag].alarmTime.text = dateFormatter.stringFromDate(date)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        setDateTimeTextEdit( sender.date, tag: sender.tag )
        if( alarms[sender.tag].active.on ){
            sendNotification(sender.date, tag: sender.tag )
        }
    }
    
    func sendNotification( date : NSDate, tag : Int ){
        let notification = UILocalNotification()
        
        notification.fireDate = date //timeIntervalSinceNow: 10 )
        notification.alertAction = "See the medicine reminder."
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = [ "AlarmNumber": tag ]
        notification.alertBody = alarms[tag].notesText.text
        
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
