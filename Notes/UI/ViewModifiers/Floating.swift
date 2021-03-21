//
//  Floating.swift
//  Notes
//
//  Created by Praveen on 17/3/21.
//

import SwiftUI
/// View modifier that makes view appears as floating on super view
struct Floating: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.blue)
            .cornerRadius(38.5)
            .padding()
            .shadow(color: Color.black.opacity(0.3),
                    radius: 3,
                    x: 3,
                    y: 3)
    }
}
