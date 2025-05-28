//
//  ViewDataView.swift
//  Free Throws
//
//  Created by Danny Gallagher on 5/27/25.
//

import SwiftUI

struct ViewDataView: View {
    @StateObject var viewModel = AthleteViewModel()
    
    var body: some View {
        Text("View Data")
            .font(.title)
        List(viewModel.athletes) { athlete in
            VStack(alignment: .leading) {
                Text(athlete.name)
                    .font(.headline)
                Text("Made: \(athlete.made) / Taken: \(athlete.taken)")
                Text("Percentage: \(String(format: "%.1f", athlete.percentage))%")
                    .foregroundColor(.green)
            }
        }
        .onAppear {
            viewModel.fetchAthletes()
        }
        Spacer()
    }
}

#Preview {
    ViewDataView()
}
