//
//  EditNotesTests.swift
//  NotesTests
//
//  Created by Praveen on 21/3/21.
//

import XCTest
@testable import Notes

class EditNotesTests: NotesTestCase {
    var editNoteViewModel: CreateOrEditNoteViewModel!
    override func setUpWithError() throws {
        try! super.setUpWithError()
        let editUseCase = EditNoteUseCase(notesRepository: repository)
        editNoteViewModel = CreateOrEditNoteViewModel(editUseCase: editUseCase)
        mockRepo.addMockNotes()
    }
    func testEditNote() {
        /// Assign
        var notesList: Notes = []
        let modifiedNote = Note(id: "id", title: "titlE", description: "modified description")
        /// Act
        editNoteViewModel.editNote(note: modifiedNote)
        getNotesListViewModel.getNotes()
        getNotesListViewModel.getNotesCompletion = { result in
            switch result {
            case .success(let notes):
                notesList = notes
            default: break
            }
        }
        getNotesListViewModel.getNotes()
        /// Assert
        XCTAssertEqual(notesList, [modifiedNote], "Notes data is not modified properly")
    }
    func testEditNoteError() {
        /// Assign
        var errorDescription: String = ""
        let modifiedNote = Note(id: "id", title: "titlE", description: "modified description")
        mockRepo.isError = true
        editNoteViewModel.completion = { result in
            switch result {
            case .failure(let error):
                errorDescription = error.getMessage()
            default: break
            }
        }
        /// Act
        editNoteViewModel.editNote(note: modifiedNote)
        /// Assert
        XCTAssertNotEqual(mockRepo.notes, [modifiedNote])
        XCTAssertEqual(errorDescription, NotesError.idNotFound().getMessage(), "Notes id not found error description is incorrect")
    }
}
