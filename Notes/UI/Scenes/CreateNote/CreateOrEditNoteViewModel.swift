//
//  CreateNoteViewModel.swift
//  Notes
//
//  Created by Praveen on 21/3/21.
//

import Foundation

/// Create or edit view model
class CreateOrEditNoteViewModel {
    // MARK:- Use cases
    var createNoteUsecase: CreateNoteUseCase!
    var editNoteUsecase: EditNoteUseCase!
    var completion: ((Completion<Void>) -> Void)?
    init(createNoteUsecase: CreateNoteUseCase) {
        self.createNoteUsecase = createNoteUsecase
    }
    init(editUseCase: EditNoteUseCase) {
        self.editNoteUsecase = editUseCase
    }
    /// Create note 
    func createNote(note: Note) {
        createNoteUsecase.execute(input: note) { result in
            self.completion?(result)
        }
    }
    /// Edit existing note
    func editNote(note: Note) {
        editNoteUsecase.execute(input: note) { result in
            self.completion?(result)
        }
    }
}
