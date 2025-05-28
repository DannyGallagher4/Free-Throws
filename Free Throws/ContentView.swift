//
//  ContentView.swift
//  Free Throws
//
//  Created by Danny Gallagher on 5/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAdd = false
    @State private var showingView = false
    
    var body: some View {
        VStack {
            Text("Free Throws")
                .font(.title)
            
            
            Text("Add Data")
                .foregroundColor(.blue)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
                )
                .onTapGesture {
                    showingAdd = true
                }
            
            Text("View Data")
                .foregroundColor(.blue)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
                )
                .onTapGesture {
                    showingView = true
                }
           
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingAdd) {
            AddDataView()
        }
        .sheet(isPresented: $showingView) {
            ViewDataView()
        }
    }
}

#Preview {
    ContentView()
}
