//
//  AddDataView.swift
//  Free Throws
//
//  Created by Danny Gallagher on 5/27/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct AddDataView: View {
    @StateObject var viewModel = AthleteViewModel()
    
    @State var selectedAthlete: String? = "None"
    @State var selectedTaken: Int? = 0
    @State var selectedMade: Int? = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Add Data")
            .font(.title)
        Form{
            Section(header: Text("Shots")) {
                Picker("Athlete", selection: $selectedAthlete){
                    ForEach(viewModel.athletes, id: \.self){ athlete in
                        Text(athlete.name)
                    }
                }
                Picker("Free Throws Made", selection: $selectedMade){
                    ForEach(0..<101) { number in
                        Text("\(number)")
                    }
                }
                Picker("Free Throws Taken", selection: $selectedTaken){
                    ForEach(0..<101) { number in
                        Text("\(number)")
                    }
                }
            }
            Section {
                Button("Submit") {
                    submitAthlete()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .onAppear {
            viewModel.fetchAthletes()
        }
        Spacer()
    }
    func submitAthlete() {
            // Example Firestore logic
            let db = Firestore.firestore()
            db.collection("athletes").addDocument(data: [
                "name": selectedAthlete!,
                "made": selectedMade!,
                "taken": selectedTaken!
            ]) { error in
                if let error = error {
                    print("Error saving athlete: \(error.localizedDescription)")
                } else {
                    print("Athlete saved successfully")
                    dismiss()
                }
            }
        }
}

#Preview {
    AddDataView()
}
