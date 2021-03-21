//
//  Title.swift
//  Notes
//
//  Created by Praveen on 17/3/21.
//

import SwiftUI

/// Title font view modifier
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle))
            .frame(width: 77, height: 70)
            .foregroundColor(Color.white)
            .padding(.bottom, 7)
    }
}
