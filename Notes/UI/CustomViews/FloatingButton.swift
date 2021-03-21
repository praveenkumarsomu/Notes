//
//  FloatingButton.swift
//  Notes
//
//  Created by Praveen on 17/3/21.
//

import SwiftUI
/// Custom view `FloatingButton` it is used to create new note in home screen 
struct FloatingButton: View {
    var text: String
    var action: (() -> Void)
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    action()
                }, label: {
                    Text(text)
                        .self.modifier(Title())
                })
                .self.modifier(Floating())
            }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(text: "+", action: {
        })
    }
}
