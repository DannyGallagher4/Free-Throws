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
    
    @State private var selectedAthlete: Athlete? = nil
    @State var selectedTaken: Int = 0
    @State var selectedMade: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Add Data")
            .font(.title)
        Form{
            Section(header: Text("Shots")) {
                Picker("Athlete", selection: $selectedAthlete) {
                    Text("None").tag(nil as Athlete?)
                    ForEach(viewModel.athletes, id: \.self) { athlete in
                        Text(athlete.name).tag(Optional(athlete))
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
                .disabled(selectedAthlete == nil)
            }
        }
        .onAppear {
            viewModel.fetchAthletes()
        }
        Spacer()
    }
    func submitAthlete() {
        
        let db = Firestore.firestore()
        let ref = db.collection("athletes").document(selectedAthlete!.idstr)
        
        let newTaken: Int = (selectedAthlete?.taken ?? 0) + selectedTaken
        let newMade: Int = (selectedAthlete?.made ?? 0) + selectedMade
        
        do {
            try ref.updateData([
                "taken": newTaken,
                "made": newMade
            ])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
        
        dismiss()
    }
}

#Preview {
    AddDataView()
}
