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

    @Environment(\.tintColor) private var tintColor
    @CareStoreFetchRequest(query: ProfileViewModel.queryPatient()) private var patients
    @CareStoreFetchRequest(query: ProfileViewModel.queryContacts()) private var contacts
    @StateObject private var viewModel = ProfileViewModel()
    @ObservedObject var loginViewModel: LoginViewModel

    // MARK: Navigation
    @State var isPresentingAddTask = false
    @State var isShowingSaveAlert = false
    @State var isPresentingContact = false
    @State var isPresentingImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ProfileImageView(viewModel: viewModel)
                    Form {
                        Section(header: Text("About")) {
                            TextField("First Name",
                                      text: $viewModel.firstName)
                            .padding()
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)

                            TextField("Last Name",
                                      text: $viewModel.lastName)
                            .padding()
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)

                            DatePicker("Birthday",
                                       selection: $viewModel.birthday,
                                       displayedComponents: [DatePickerComponents.date])
                            .padding()
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                        }

                        Section(header: Text("Contact")) {
                            TextField("Street", text: $viewModel.street)
                            TextField("City", text: $viewModel.city)
                            TextField("State", text: $viewModel.state)
                            TextField("Postal code", text: $viewModel.zipcode)
                        }
                    }
                }

                Button(action: {
                    Task {
                        await viewModel.saveProfile()
                    }
                }, label: {
                    Text("Save Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                })
                .background(Color(.green))
                .cornerRadius(15)

                // Notice that "action" is a closure (which is essentially
                // a function as argument like we discussed in class)
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
                .background(Color(.red))
                .cornerRadius(15)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("My Contact") {
                        viewModel.isPresentingContact = true
                    }
                    .sheet(isPresented: $viewModel.isPresentingContact) {
                        MyContactView()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Task") {
                        isPresentingAddTask = true
                    }
                    .sheet(isPresented: $isPresentingAddTask) {
                        CareKitTaskView()
                    }
                }
            }
            .sheet(isPresented: $viewModel.isPresentingImagePicker) {
                ImagePicker(image: $viewModel.profileUIImage)
            }
            .alert(isPresented: $viewModel.isShowingSaveAlert) {
                return Alert(title: Text("Update"),
                             message: Text(viewModel.alertMessage),
                             dismissButton: .default(Text("Ok"), action: {
                                viewModel.isShowingSaveAlert = false
                             }))
            }
        }
        .onReceive(patients.publisher) { publishedPatient in
            viewModel.updatePatient(publishedPatient.result)
        }
        .onReceive(contacts.publisher) { publishedContact in
            viewModel.updateContact(publishedContact.result)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(loginViewModel: .init())
            .accentColor(Color(TintColorKey.defaultValue))
            .environment(\.careStore, Utility.createPreviewStore())
    }
}
