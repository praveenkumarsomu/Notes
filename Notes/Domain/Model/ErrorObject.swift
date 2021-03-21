//
//  ErrorObject.swift
//  Notes
//
//  Created by Praveen on 21/3/21.
//

import Foundation
/// Error object that contains the Alert message value
struct ErrorObject: Identifiable {
    var id: String { description }
    var description: String
}
