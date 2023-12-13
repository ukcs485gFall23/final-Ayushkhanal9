//
//  CareKitTaskViewModel.swift
//  OCKSample
//
//  Created by Corey Baker on 10/31/23.
//  Copyright © 2023 Network Reconnaissance Lab. All rights reserved.
//
import Foundation
import CareKitStore
import os.log

@MainActor
class CareKitTaskViewModel: ObservableObject {

    @Published var error: AppError?

    private func setSchedule(userSchedule: TaskScheduleOptions) -> OCKSchedule {
        switch userSchedule {
        case .everyDay:
            return OCKSchedule.dailyAtTime(hour: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            text: nil)
        case .everyOtherDay:
            let element = OCKScheduleElement(start: Date(),
                                             end: nil,
                                             interval: DateComponents(day: 2))
            let composedSchedule = OCKSchedule(composing: [element])
            return composedSchedule
        case .onceAWeekSunday:
            return OCKSchedule.weeklyAtTime(weekday: 1,
                                            hours: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            targetValues: [],
                                            text: nil)
        case .onceAWeekMonday:
            return OCKSchedule.weeklyAtTime(weekday: 2,
                                            hours: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            targetValues: [],
                                            text: nil)
        case .onceAWeekTuesday:
            return OCKSchedule.weeklyAtTime(weekday: 3,
                                            hours: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            targetValues: [],
                                            text: nil)
        case .onceAWeekWednesday:
            return OCKSchedule.weeklyAtTime(weekday: 4,
                                            hours: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            targetValues: [],
                                            text: nil)
        case .onceAWeekThursday:
            return OCKSchedule.weeklyAtTime(weekday: 5,
                                            hours: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            targetValues: [],
                                            text: nil)
        case .onceAWeekFriday:
            return OCKSchedule.weeklyAtTime(weekday: 6,
                                            hours: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            targetValues: [],
                                            text: nil)
        case .onceAWeekSaturday:
            return OCKSchedule.weeklyAtTime(weekday: 7,
                                            hours: 0,
                                            minutes: 0,
                                            start: Date(),
                                            end: nil,
                                            targetValues: [],
                                            text: nil)
        }
    }

    // MARK: Intents
    func addTask(
        _ title: String,
        instructions: String,
        schedule: TaskScheduleOptions,
        cardType: CareKitCard
    ) async {
        guard let appDelegate = AppDelegateKey.defaultValue else {
            error = AppError.couldntBeUnwrapped
            return
        }
        let uniqueId = UUID().uuidString // Create a unique id for each task
        var task = OCKTask(id: uniqueId,
                           title: title,
                           carePlanUUID: nil,
                           schedule: .dailyAtTime(hour: 0,
                                                  minutes: 0,
                                                  start: Date(),
                                                  end: nil,
                                                  text: nil))
        task.instructions = instructions
        task.schedule = setSchedule(userSchedule: schedule)
        task.card = cardType
        do {
            try await appDelegate.store.addTasksIfNotPresent([task])
            Logger.careKitTask.info("Saved task: \(task.id, privacy: .private)")
            // Notify views they should refresh tasks if needed
            NotificationCenter.default.post(.init(name: Notification.Name(rawValue: Constants.shouldRefreshView)))
        } catch {
            self.error = AppError.errorString("Could not add task: \(error.localizedDescription)")
        }
    }

    func addHealthKitTask(
        _ title: String,
        instructions: String,
        schedule: TaskScheduleOptions,
        cardType: CareKitCard
    ) async {
        guard let appDelegate = AppDelegateKey.defaultValue else {
            error = AppError.couldntBeUnwrapped
            return
        }
        let uniqueId = UUID().uuidString // Create a unique id for each task
        var healthKitTask = OCKHealthKitTask(id: uniqueId,
                                             title: title,
                                             carePlanUUID: nil,
                                             schedule: .dailyAtTime(hour: 0,
                                                                    minutes: 0,
                                                                    start: Date(),
                                                                    end: nil,
                                                                    text: nil),
                                             healthKitLinkage: .init(quantityIdentifier: .electrodermalActivity,
                                                                     quantityType: .discrete,
                                                                     unit: .count()))
        healthKitTask.instructions = instructions
        healthKitTask.schedule = setSchedule(userSchedule: schedule)
        healthKitTask.card = cardType
        do {
            try await appDelegate.healthKitStore.addTasksIfNotPresent([healthKitTask])
            Logger.careKitTask.info("Saved HealthKitTask: \(healthKitTask.id, privacy: .private)")
            // Notify views they should refresh tasks if needed
            NotificationCenter.default.post(.init(name: Notification.Name(rawValue: Constants.shouldRefreshView)))
            // Ask HealthKit store for permissions after each new task
            Utility.requestHealthKitPermissions()
        } catch {
            self.error = AppError.errorString("Could not add task: \(error.localizedDescription)")
        }
    }
}
