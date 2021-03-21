//
//  CreateNoteTests.swift
//  NotesTests
//
//  Created by Praveen on 21/3/21.
//

import XCTest
@testable import Notes

class CreateNoteTests: NotesTestCase {
    var editNoteViewModel: CreateOrEditNoteViewModel!
    override func setUpWithError() throws {
        try! super.setUpWithError()
        let createUseCase = CreateNoteUseCase(notesRepository: repository)
        editNoteViewModel = CreateOrEditNoteViewModel(usecase: createUseCase)
        mockRepo.addMockNotes()
    }

    func testCreatingNewNote() {
        /// Assign
        var notesList: Notes = []
        let newNote = Note(id: "id", title: "titlE", description: "modified description")
        /// Act
        editNoteViewModel.createNote(note: newNote)
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
        XCTAssertEqual(mockRepo.notes.count, 2, "Creating a note not added it to the repo")
        XCTAssertEqual(notesList, mockRepo.notes , "Notes is not returned properly after creating new note")
    }

    func testCreatingNewNoteError() {
        /// Assign
        var errorDescription: String = ""
        let newNote = Note(id: "id", title: "titlE", description: "modified description")
        mockRepo.isError = true
        editNoteViewModel.completion = { result in
            switch result {
            case .failure(let error):
                errorDescription = error.getMessage()
            default: break
            }
        }
        /// Act
        editNoteViewModel.createNote(note: newNote)
        /// Assert
        XCTAssertEqual(mockRepo.notes.count, 1, "Creating a note not added it to the repo")
        XCTAssertEqual(errorDescription, NotesError.genericError().getMessage())
    }

}
