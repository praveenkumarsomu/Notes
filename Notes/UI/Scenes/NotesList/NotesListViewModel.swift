//
//  NotesListViewModel.swift
//  Notes
//
//  Created by Praveen on 17/3/21.
//

import Foundation
/// Delete/Display list of the Notes screen viewmodel
class NotesListViewModel {
    // MARK:- Use cases
    let getNotesUseCase: GetNotesUseCase
    let deleteNoteUseCase: DeleteNoteUseCase
    var getNotesCompletion: ((Completion<Notes>) -> Void)?
    var deleteNoteCompletion: ((Completion<Void>) -> Void)?
    init(getNotesUsecase: GetNotesUseCase, deleteUseCase: DeleteNoteUseCase) {
        self.getNotesUseCase = getNotesUsecase
        self.deleteNoteUseCase = deleteUseCase
    }
    /// Get's list of notes from Repository
    func getNotes() {
        getNotesUseCase.execute { result in
            self.getNotesCompletion?(result)
        }
    }
    /// Delete note from FireStore
    func deleteNote(note: Note) {
        deleteNoteUseCase.execute(input: note) { result in
            self.deleteNoteCompletion?(result)
        }
    }
}
