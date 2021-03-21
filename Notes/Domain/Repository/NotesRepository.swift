//
//  NotesRepository.swift
//  Notes
//
//  Created by Praveen on 16/3/21.
//

import Foundation
typealias Notes = [Note]
typealias Completion<T> = Result<T, NotesError>
typealias CompletionBlock<T> = ((Completion<T>) -> Void)

/// Notes repository Protocol
protocol NotesRepository {
    func getNotes(completion: @escaping CompletionBlock<Notes>)
    func save(note: Note, completion: @escaping CompletionBlock<Void>)
    func deleteNote(note: Note, completion: @escaping CompletionBlock<Void>)
    func createNote(note: Note, completion: @escaping CompletionBlock<Void>)
}
