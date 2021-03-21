//
//  GetNotesUseCase.swift
//  Notes
//
//  Created by Praveen on 17/3/21.
//

import Foundation

/// Gets the list of the application
struct GetNotesUseCase: UseCase {
    typealias Output = CompletionBlock<Notes>
    /// Notes repository
    let repository: NotesRepository!
    init(notesRepository: NotesRepository) {
        self.repository = notesRepository
    }
    func execute(completion: @escaping Output) {
        repository.getNotes { result in
            switch result {
            case .success(let notes):
                completion(.success(notes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
