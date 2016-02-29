//
//  Alarm.swift
//  BMICalcLectureNOTES
//
//  Created by Jones, Dave on 2/29/16.
//  Copyright © 2016 Jones, Dave. All rights reserved.
//

import Foundation
import UIKit

class Alarm {
    var alarmTime : UITextField
    var notesText : UITextField
    var recurring : UISwitch
    var active    : UISwitch
    
    init( alarmTime : UITextField,
        notesText : UITextField,
        recurring : UISwitch,
        active : UISwitch ){
            self.alarmTime = alarmTime
            self.notesText = notesText
            self.recurring = recurring
            self.active = active
    }
}