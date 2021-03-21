//
//  Note.swift
//  Notes
//
//  Created by Praveen on 16/3/21.
//

import Foundation

/// Note Model used through out the Application
struct Note: Equatable {
    var id: String?
    var title: String?
    var description: String?
    init(title: String?, description: String?) {
        self.title = title
        self.description = description
    }
    init(id: String?, title: String?, description: String?) {
        self.id = id
        self.title = title
        self.description = description
    }
}
