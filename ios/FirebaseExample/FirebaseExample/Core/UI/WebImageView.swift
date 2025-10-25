//
//  WebImageView.swift
//  FirebaseExample
//
//  Created by Richard Moult on 22/10/2025.
//

import SwiftUI
import SDWebImageSwiftUI

/*

 Use WebImageView to show an image at location imageUrl
 The image opcacity changes from 0 to 1 once the image has loaded
 
 example:
    WebImageView(imageUrl: "https://someimageurl", width: 100, height: 100)
 
*/

struct WebImageView: View {
    var imageUrl: String
    var width: CGFloat
    var height: CGFloat

    @State private var loadImageSuccessfully = true
    @State private var imageOpacity = 0.0  // Initial opacity for the fade-in effect

    var body: some View {
        ZStack {
            if loadImageSuccessfully {
                WebImage(url: URL(string: imageUrl))
                    .onFailure { _ in
                        loadImageSuccessfully = false
                    }
                    .onSuccess { image, data, cacheType in
                        if cacheType.rawValue == 0 {
                            Task {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    imageOpacity = 1.0  // Animate to full opacity for fresh downloads
                                }
                            }
                        } else {
                            Task {
                                imageOpacity = 1.0  // Set to full opacity immediately if from cache
                            }
                        }
                    }
                    .resizable()
                    .indicator(.activity)
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primary, lineWidth: 3)
                            .opacity(imageOpacity)
                    )
                    .opacity(imageOpacity)  // Apply the dynamic opacity
            } else {
                Image("blank")
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primary, lineWidth: 3)
                    )
            }
        }
        .frame(width: width) // Set a fixed width for the entire view
    }
}
