//
//  TryAgainView.swift
//  FirebaseExample
//
//  Created by Richard Moult on 21/10/2025.
//

import SwiftUI

/*
 Use TryAgainView to display to the user a "try again" button that when
 tapped calls the action function
 
 example:
 
    TryAgainView(title: "Sorry something went wrong",
                 desciption: "more description",
                 action: { viewModel.refreshData() })
*/

struct TryAgainView: View {

    var title: String
    var description: String
    var action: (() -> Void)

    var body: some View {
        VStack(spacing: 0) {
            
            Text(title)
                .font(.title)
            Text(description)
                .font(.headline)

            Button(action: {
                // Define what the button should do when tapped
                action()
            }) {
                Text("Try Again")
                    .fontWeight(.semibold)
                    .foregroundColor(.black) // Set the text color to white
            }
            .padding() // Add padding around the text
            .cornerRadius(10) // Apply rounded corners with a radius of 10
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
