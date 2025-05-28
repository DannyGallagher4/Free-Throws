//
//  Athlete.swift
//  Free Throws
//
//  Created by Danny Gallagher on 5/27/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore

struct Athlete: Identifiable, Hashable {
    var id: String
    var name: String
    var taken: Int
    var made: Int

    var percentage: Double {
        taken == 0 ? 0 : (Double(made) / Double(taken)) * 100
    }
}

class AthleteViewModel: ObservableObject {
    @Published var athletes: [Athlete] = []

    let db = Firestore.firestore()

    func fetchAthletes() {
        db.collection("athletes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching athletes: \(error)")
                return
            }

            if let documents = snapshot?.documents {
                self.athletes = documents.compactMap { doc in
                    let data = doc.data()
                    let name = data["name"] as? String ?? "Unknown"
                    let taken = data["taken"] as? Int ?? 0
                    let made = data["made"] as? Int ?? 0

                    return Athlete(id: doc.documentID, name: name, taken: taken, made: made)
                }
            }
        }
    }
}
