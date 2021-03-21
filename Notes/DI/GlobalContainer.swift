//
//  GlobalContainer.swift
//  Notes
//
//  Created by Praveen on 16/3/21.
//

import Foundation
import Swinject

let container: Container = {
    let container = Container()
    // NotesRepository
    container.register(NotesRepository.self) { resolver in
        let repo = NotesRepositoryImplementation()
        return repo
    }
    /// Get notes usecase
    container.register(GetNotesUseCase?.self) { resolver in
        var getnoteUseCase: GetNotesUseCase?
        if let repo = container.resolve(NotesRepository.self) {
            getnoteUseCase = GetNotesUseCase(notesRepository: repo)
        }
        return getnoteUseCase
    }
    /// Edit note use case
    container.register(EditNoteUseCase?.self) { resolver in
        var editnoteUseCase: EditNoteUseCase?
        if let repo = container.resolve(NotesRepository.self) {
            editnoteUseCase = EditNoteUseCase(notesRepository: repo)
        }
        return editnoteUseCase
    }
    /// Create note use case
    container.register(CreateNoteUseCase?.self) { resolver in
        var editnoteUseCase: CreateNoteUseCase?
        if let repo = container.resolve(NotesRepository.self) {
            editnoteUseCase = CreateNoteUseCase(notesRepository: repo)
        }
        return editnoteUseCase
    }
    /// Delete notes usecase
    container.register(DeleteNoteUseCase?.self) { resolver in
        var deleteNoteUseCase: DeleteNoteUseCase?
        if let repo = container.resolve(NotesRepository.self) {
            deleteNoteUseCase = DeleteNoteUseCase(notesRepository: repo)
        }
        return deleteNoteUseCase
    }
    return container
}()
