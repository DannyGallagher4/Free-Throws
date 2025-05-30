//
//  AddPlayerView.swift
//  Free Throws
//
//  Created by Danny Gallagher on 5/29/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct AddPlayerView: View {
    @State private var name: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("New Athlete")
            .font(.title)
        
        Form{
            Section(header: Text("Enter Name")) {
                TextField("Athlete Name", text: $name)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
            }

            Section {
                Button("Submit") {
                    submitName()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        
        Spacer()
    }
    
    func submitName() {
        let db = Firestore.firestore()
        db.collection("athletes").addDocument(data: [
            "name": name,
            "made": 0,
            "taken": 0
        ])
        dismiss()
    }
}

#Preview {
    AddPlayerView()
}
