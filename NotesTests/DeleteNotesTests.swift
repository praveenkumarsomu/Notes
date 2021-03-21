//
//  DeleteNotesUseCase.swift
//  NotesTests
//
//  Created by Praveen on 21/3/21.
//

import XCTest
@testable import Notes

class DeleteNotesTests: NotesTestCase {
    override func setUpWithError() throws {
        try! super.setUpWithError()
        mockRepo.addMockNotes()
    }

    func testDeletingNotes() {
        /// Assign
        var notesList: Notes = []
        getNotesListViewModel.deleteNoteCompletion = { result in
        }
        /// Act
        getNotesListViewModel.deleteNote(note: mockRepo.notes.first!)
        getNotesListViewModel.getNotes()
        getNotesListViewModel.getNotesCompletion = { result in
            switch result {
            case .success(let notes):
                notesList = notes
            default: break
            }
        }
        /// Assert
        XCTAssertTrue(notesList.isEmpty, "Deleted note is retuned from repo")
    }
    func testDeleteNoteError() {
        /// Assign
        var errorDescription: String = ""
        mockRepo.isError = true
        getNotesListViewModel.deleteNoteCompletion = { result in
            switch result {
            case .failure(let error):
                errorDescription = error.getMessage()
            default: break
            }
        }
        /// Act
        getNotesListViewModel.deleteNote(note: mockRepo.notes.first!)
        /// Assert
        XCTAssertFalse(mockRepo.notes.isEmpty, "In case of Deletion failure note is removed from repo")
        XCTAssertEqual(errorDescription, NotesError.idNotFound().getMessage(), "Notes id not found error description is incorrect")
    }

}
