//
//  GetNotesTests.swift
//  NotesTests
//
//  Created by Praveen on 21/3/21.
//

import XCTest
@testable import Notes

class GetNotesTests: NotesTestCase {    
    func testGettingNotes() {
        /// Assign
        var notesList: Notes = []
        mockRepo.addMockNotes()
        getNotesListViewModel.getNotesCompletion = { result in
            switch result {
            case .success(let notes):
                notesList = notes
            default: break
            }
        }
        /// Act
        getNotesListViewModel.getNotes()
        /// Assert
        XCTAssertFalse(notesList.isEmpty, "Notes list is empty it should contain one value")
        XCTAssertEqual(notesList, mockRepo.notes, "Get notes use case not returned same value as in Repository")
    }
    func testGettingNotesError() {
        /// Assign
        var errorDescription: String = ""
        mockRepo.isError = true
        mockRepo.addMockNotes()
        getNotesListViewModel.getNotesCompletion = { result in
            switch result {
            case .failure(let error):
                errorDescription = error.getMessage()
            default: break
            }
        }
        /// Act
        getNotesListViewModel.getNotes()
        /// Assert
        XCTAssertFalse(errorDescription.isEmpty, "Notes id not found error description not returned properly")
        XCTAssertEqual(errorDescription, NotesError.idNotFound().getMessage(), "Notes id not found error description is incorrect")
    }

}
