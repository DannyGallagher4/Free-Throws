//
//  RemoveAthleteView.swift
//  Free Throws
//
//  Created by Danny Gallagher on 5/29/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct RemoveAthleteView: View {
    @StateObject var viewModel = AthleteViewModel()
    
    @State private var selectedAthlete: Athlete? = nil
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Text("Add Data")
            .font(.title)
        Form{
            Section {
                Picker("Athlete", selection: $selectedAthlete) {
                    Text("None").tag(nil as Athlete?)
                    ForEach(viewModel.athletes, id: \.self) { athlete in
                        Text(athlete.name).tag(Optional(athlete))
                    }
                }
            }
            Section {
                Button("Submit") {
                    removeAthlete()
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
    
    func removeAthlete() {
        let db = Firestore.firestore()

        db.collection("athletes").document(selectedAthlete?.idstr ?? "").delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted!")
            }
        }
        dismiss()
    }
}

#Preview {
    RemoveAthleteView()
}
