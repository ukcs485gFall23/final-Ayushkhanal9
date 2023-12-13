//
//  TaskScheduleOptions.swift
//  OCKSample
//
//  Created by Aayush Khanal on 12/12/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//

import Foundation

enum TaskScheduleOptions: String, CaseIterable, Identifiable {
    var id: Self { self }
    case everyDay = "Every Day"
    case everyOtherDay = "Every Other Day"
    case onceAWeekMonday = "Once a Week on Monday"
    case onceAWeekTuesday = "Once a Week on Tuesday"
    case onceAWeekWednesday = "Once a Week on Wednesday"
    case onceAWeekThursday = "Once a Week on Thursday"
    case onceAWeekFriday = "Once a Week on Friday"
    case onceAWeekSaturday = "Once a Week on Saturday"
    case onceAWeekSunday = "Once a Week on Sunday"
}
