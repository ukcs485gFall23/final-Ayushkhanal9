//
//  ProfileView.swift
//  OCKSample
//
//  Created by Corey Baker on 11/24/20.
//  Copyright © 2020 Network Reconnaissance Lab. All rights reserved.
//

import CareKitUI
import CareKitStore
import CareKit
import os.log
import SwiftUI

struct ProfileView: View {
    private static var query = OCKPatientQuery(for: Date())
    @CareStoreFetchRequest(query: query) private var patients
    @StateObject private var viewModel = ProfileViewModel()
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var isPresentingAddTask = false

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    TextField("First Name", text: $viewModel.firstName)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)

                    TextField("Last Name", text: $viewModel.lastName)
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)

                    DatePicker("Birthday", selection: $viewModel.birthday, displayedComponents: [.date])
                        .padding()
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }

                Button(action: {
                    Task {
                        do {
                            try await viewModel.saveProfile()
                        } catch {
                            let profileLog = OSLog(subsystem: "com.yourapp.subsystem", category: "Profile")
                            os_log("Error saving profile: %@", log: profileLog, type: .error, "\(error)")
                        }
                    }
                }, label: {
                    Text("Save Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color.green)
                .cornerRadius(15)

                Button(action: {
                    Task {
                        await loginViewModel.logout()
                    }
                }, label: {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color.red)
                .cornerRadius(15)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Task") {
                        isPresentingAddTask = true
                    }
                    .sheet(isPresented: $isPresentingAddTask) {
                        CareKitTaskView()
                    }
                }
            }
            .onReceive(patients.publisher) { publishedPatient in
                viewModel.updatePatient(publishedPatient.result)
            }
        }
        .navigationTitle("Profile")
        .accentColor(Color(TintColorKey.defaultValue))
        .environment(\.careStore, Utility.createPreviewStore())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(loginViewModel: .init())
    }
}
