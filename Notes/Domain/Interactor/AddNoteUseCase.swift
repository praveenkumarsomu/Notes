//
//  AddNoteUseCase.swift
//  Notes
//
//  Created by Praveen on 17/3/21.
//

import Foundation
/// Create new note use case
struct CreateNoteUseCase: UseCaseWithParameter {
    typealias Output = CompletionBlock<Void>
    typealias Input = Note
    /// Notes repository this is registerd in global container class (Dependency injection using Swinject)
    let repository: NotesRepository
    init(notesRepository: NotesRepository) {
        self.repository = notesRepository
    }
    func execute(input: Note, completion: @escaping CompletionBlock<Void>) {
        repository.createNote(note: input) { result in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
