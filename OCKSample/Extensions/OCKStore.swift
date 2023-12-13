//
//  OCKStore.swift
//  OCKSample
//
//  Created by Corey Baker on 1/5/22.
//  Copyright © 2022 Network Reconnaissance Lab. All rights reserved.
//

import Foundation
import CareKitStore
import Contacts
import os.log
import ParseSwift
import ParseCareKit

extension OCKStore {

    /**
     Adds an `OCKAnyCarePlan`*asynchronously*  to `OCKStore` if it has not been added already.
     - parameter carePlans: The array of `OCKAnyCarePlan`'s to be added to the `OCKStore`.
     - parameter patientUUID: The uuid of the `OCKPatient` to tie to the `OCKCarePlan`. Defaults to nil.
     - throws: An error if there was a problem adding the missing `OCKAnyCarePlan`'s.
     - note: `OCKAnyCarePlan`'s that have an existing `id` will not be added and will not cause errors to be thrown.
    */
    func addCarePlansIfNotPresent(_ carePlans: [OCKAnyCarePlan], patientUUID: UUID? = nil) async throws {
        let carePlanIdsToAdd = carePlans.compactMap { $0.id }

        // Prepare query to see if Care Plan are already added
        var query = OCKCarePlanQuery(for: Date())
        query.ids = carePlanIdsToAdd
        let foundCarePlans = try await self.fetchAnyCarePlans(query: query)
        var carePlanNotInStore = [OCKAnyCarePlan]()
        // Check results to see if there's a missing Care Plan
        carePlans.forEach { potentialCarePlan in
            if foundCarePlans.first(where: { $0.id == potentialCarePlan.id }) == nil {
                // Check if can be casted to OCKCarePlan to add patientUUID
                guard var mutableCarePlan = potentialCarePlan as? OCKCarePlan else {
                    carePlanNotInStore.append(potentialCarePlan)
                    return
                }
                mutableCarePlan.patientUUID = patientUUID
                carePlanNotInStore.append(mutableCarePlan)
            }
        }

        // Only add if there's a new Care Plan
        if carePlanNotInStore.count > 0 {
            do {
                _ = try await self.addAnyCarePlans(carePlanNotInStore)
                Logger.ockStore.info("Added Care Plans into OCKStore!")
            } catch {
                Logger.ockStore.error("Error adding Care Plans: \(error.localizedDescription)")
            }
        }
    }

    func addTasksIfNotPresent(_ tasks: [OCKTask]) async throws {
        let taskIdsToAdd = tasks.compactMap { $0.id }

        // Prepare query to see if tasks are already added
        var query = OCKTaskQuery(for: Date())
        query.ids = taskIdsToAdd

        let foundTasks = try await fetchTasks(query: query)
        var tasksNotInStore = [OCKTask]()

        // Check results to see if there's a missing task
        tasks.forEach { potentialTask in
            if foundTasks.first(where: { $0.id == potentialTask.id }) == nil {
                tasksNotInStore.append(potentialTask)
            }
        }

        // Only add if there's a new task
        if tasksNotInStore.count > 0 {
            do {
                _ = try await addTasks(tasksNotInStore)
                Logger.ockStore.info("Added tasks into OCKStore!")
            } catch {
                Logger.ockStore.error("Error adding tasks: \(error)")
            }
        }
    }

    func addContactsIfNotPresent(_ contacts: [OCKContact]) async throws {
        let contactIdsToAdd = contacts.compactMap { $0.id }

        // Prepare query to see if contacts are already added
        var query = OCKContactQuery(for: Date())
        query.ids = contactIdsToAdd

        let foundContacts = try await fetchContacts(query: query)
        var contactsNotInStore = [OCKContact]()

        // Check results to see if there's a missing task
        contacts.forEach { potential in
            if foundContacts.first(where: { $0.id == potential.id }) == nil {
                contactsNotInStore.append(potential)
            }
        }

        // Only add if there's a new task
        if contactsNotInStore.count > 0 {
            do {
                _ = try await addContacts(contactsNotInStore)
                Logger.ockStore.info("Added contacts into OCKStore!")
            } catch {
                Logger.ockStore.error("Error adding contacts: \(error)")
            }
        }
    }

    // Adds tasks and contacts into the store
    func populateSampleData() async throws {

        let thisMorning = Calendar.current.startOfDay(for: Date())
        // let aFewDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: thisMorning)!
        let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 6, to: thisMorning)!
        let afterLunch = Calendar.current.date(byAdding: .hour, value: 14, to: thisMorning)!

        let schedule = OCKSchedule(composing: [
            OCKScheduleElement(start: Calendar.current.date(byAdding: .hour, value: 6, to: beforeBreakfast)!,
                               end: nil,
                               interval: DateComponents(day: 1)),

            OCKScheduleElement(start: Calendar.current.date(byAdding: .hour, value: 6, to: afterLunch)!,
                               end: nil,
                               interval: DateComponents(day: 2))
        ])


        let mornElement = OCKScheduleElement(start: beforeBreakfast,
                                                 end: nil,
                                                 interval: DateComponents(day: 1),
                                                 text: "Morning Check-in")
         let afternoonElement = OCKScheduleElement(start: afterLunch,
                                                end: nil,
                                                interval: DateComponents(day: 2),
                                                text: "Afternoon Check-in")
         let eveningElement = OCKScheduleElement(start: Calendar.current.date(byAdding: .hour, value: 5, to: afterLunch)!,
                                                end: nil,
                                                interval: DateComponents(day: 1),
                                                text: "Evening Check-in")
         let journalSchedule = OCKSchedule(composing: [mornElement, afternoonElement, eveningElement])
         var simpleJournal = OCKTask(id: TaskID.journaling,     // Daily Journaling
                                       title: "Daily Journaling",
                                       carePlanUUID: nil,
                                       schedule: journalSchedule)
         simpleJournal.card = .checklist
         simpleJournal.instructions = "Periodic check-ins with yourself for grounding."
         simpleJournal.asset = "book"
        
        
        var selfReflection = OCKTask(id: TaskID.selfReflection,       // Meditation
                                 title: "Meditation and Breath work",
                                 carePlanUUID: nil,
                                 schedule: schedule)
        selfReflection.instructions = "Taking a break from daily sctivites to clear your mind and center yourself."
        selfReflection.asset = "book"
        selfReflection.card = .instruction

        let sadCountSchedule = OCKSchedule(composing: [         // Sadness Tracker
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1),
                               text: "Across the entire day",
                               targetValues: [], duration: .allDay)
            ])

        var sadCounter = OCKTask(id: TaskID.sadCounter,
                             title: "Sad Counter",
                             carePlanUUID: nil,
                             schedule: sadCountSchedule)
        sadCounter.impactsAdherence = false
        sadCounter.instructions = "Tap the button below anytime you feel sad or down."
        sadCounter.asset = "bed.double"
        sadCounter.card = .button

        let happyCountSchedule = OCKSchedule(composing: [         // Happiness Tracker
            OCKScheduleElement(start: beforeBreakfast,
                               end: nil,
                               interval: DateComponents(day: 1),
                               text: "Across the entire day",
                               targetValues: [], duration: .allDay)
            ])

        var happyCounter = OCKTask(id: TaskID.happyCounter,
                             title: "Happy Counter",
                             carePlanUUID: nil,
                             schedule: happyCountSchedule)
        happyCounter.impactsAdherence = false
        happyCounter.instructions = "Tap the button below anytime you feel happy or exicted."
        happyCounter.asset = "bed.double"
        happyCounter.card = .button
        
        let dailyMedsElement = OCKScheduleElement(start: afterLunch,    // meds
                                              end: nil,
                                              interval: DateComponents(day: 1))
        let dailyMedsSchedule = OCKSchedule(composing: [dailyMedsElement])
        var dailyMeds = OCKTask(id: TaskID.medication,
                             title: "Take Daily Medication",
                             carePlanUUID: nil,
                             schedule: dailyMedsSchedule)
        dailyMeds.impactsAdherence = true
        dailyMeds.instructions = "Take all necessary daily medications including vitamins and supplements."
        dailyMeds.card = .simple

        let stretchElement = OCKScheduleElement(start: beforeBreakfast,   // workout
                                                end: nil,
                                                interval: DateComponents(day: 2))
        let stretchSchedule = OCKSchedule(composing: [stretchElement])
        var stretch = OCKTask(id: TaskID.stretch,
                              title: "Workout",
                              carePlanUUID: nil,
                              schedule: stretchSchedule)
        stretch.impactsAdherence = true
        stretch.asset = "figure.run"
        stretch.card = .instruction
        
        try await addTasksIfNotPresent([dailyMeds, stretch, selfReflection, sadCounter, happyCounter, simpleJournal])

        var contact1 = OCKContact(id: "jane",
                                  givenName: "Jane",
                                  familyName: "Daniels",
                                  carePlanUUID: nil)
        contact1.asset = "JaneDaniels"
        contact1.title = "Family Practice Doctor"
        contact1.role = "Dr. Daniels is a family practice doctor with 8 years of experience."
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "janedaniels@uky.edu")]
        contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 257-2000")]
        contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 357-2040")]

        contact1.address = {
            let address = OCKPostalAddress()
            address.street = "2195 Harrodsburg Rd"
            address.city = "Lexington"
            address.state = "KY"
            address.postalCode = "40504"
            return address
        }()

        var contact2 = OCKContact(id: "matthew", givenName: "Matthew",
                                  familyName: "Reiff", carePlanUUID: nil)
        contact2.asset = "MatthewReiff"
        contact2.title = "OBGYN"
        contact2.role = "Dr. Reiff is an OBGYN with 13 years of experience."
        contact2.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 257-1000")]
        contact2.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(859) 257-1234")]
        contact2.address = {
            let address = OCKPostalAddress()
            address.street = "1000 S Limestone"
            address.city = "Lexington"
            address.state = "KY"
            address.postalCode = "40536"
            return address
        }()

        try await addContactsIfNotPresent([contact1, contact2])
    }
}
