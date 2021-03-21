//
//  NotesTestCase.swift
//  NotesTests
//
//  Created by Praveen on 21/3/21.
//

import XCTest
@testable import Notes

class MockRepository: NotesRepository {
    var notes: Notes = []
    var isError: Bool = false
    func getNotes(completion: @escaping CompletionBlock<Notes>) {
        if isError {
            completion(.failure(.idNotFound()))
        } else {
            completion(.success(notes))
        }
    }
    
    func save(note: Note, completion: @escaping CompletionBlock<Void>) {
        if isError {
            completion(.failure(.idNotFound()))
        } else {
            /// Since we added one note in mock replacing it directly here
            notes = [note]
            completion(.success(()))
        }
    }
    
    func deleteNote(note: Note, completion: @escaping CompletionBlock<Void>) {
        if isError {
            completion(.failure(.idNotFound()))
        } else {
            /// Since we added one note in mock removing all
            notes.removeAll()
            completion(.success(()))
        }
    }
    
    func createNote(note: Note, completion: @escaping CompletionBlock<Void>) {
        if isError {
            completion(.failure(.genericError()))
        } else {
            notes.append(note)
            completion(.success(()))
        }
    }
}

extension MockRepository {
    func addMockNotes() {
        notes = [Note(id: "id", title: "title", description: "Description")]
    }
    func emptyNotes() {
        notes.removeAll()
    }
}

class NotesTestCase: XCTestCase {
    var repository: NotesRepository = MockRepository()
    var getNotesListViewModel: NotesListViewModel!
    var mockRepo: MockRepository {
        return repository as! MockRepository
    }
    override func setUpWithError() throws {
        let deleteUseCase = DeleteNoteUseCase(notesRepository: repository)
        let getUsecase = GetNotesUseCase(notesRepository: repository)
        getNotesListViewModel = NotesListViewModel(usecase: getUsecase, deleteUseCase: deleteUseCase)
    }
    override func tearDownWithError() throws {
        (repository as? MockRepository)?.isError = false
        mockRepo.emptyNotes()
    }
}
