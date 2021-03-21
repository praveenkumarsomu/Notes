//
//  NotesRepository.swift
//  Notes
//
//  Created by Praveen on 16/3/21.
//

import Foundation
import Firebase
/// Notes repository implementation using Firestore
class NotesRepositoryImplementation: NotesRepository {
    let db = Firestore.firestore()
    let collection = "list"
    func getNotes(completion: @escaping CompletionBlock<Notes>) {
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(Completion.failure(.serverError(err.localizedDescription)))
                print("Error getting documents: \(err)")
            } else {
                var notes: Notes = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    var note = Note(title: data["title"] as? String, description: data["description"] as? String)
                    note.id = document.documentID
                    notes.append(note)
                    print("\(document.documentID) => \(document.data())")
                }
                completion(Completion.success(notes))
            }
        }
    }
    
    func save(note: Note, completion: @escaping CompletionBlock<Void>) {
        guard let id = note.id else {
            completion(.failure(.idNotFound()))
            return
        }
        db.collection(collection).document("\(id)").updateData(["title": note.title ?? "", "description": note.description ?? ""], completion: { error in
            if let err = error {
                completion(.failure(.serverError(err.localizedDescription)))
            } else {
                completion(.success(()))
            }
        })
    }
    func deleteNote(note: Note, completion: @escaping CompletionBlock<Void>) {
        guard let id = note.id else {
            completion(.failure(.idNotFound()))
            return
        }
        db.collection(collection).document("\(id)").delete() { err in
            if let err = err {
                completion(.failure(.serverError(err.localizedDescription)))
            } else {
                completion(.success(()))
            }
        }
    }
    func createNote(note: Note, completion: @escaping CompletionBlock<Void>) {
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: [
            "title": note.title ?? "",
            "description": note.description ?? ""
        ]) { err in
            if let err = err {
                completion(.failure(.serverError(err.localizedDescription)))
            } else {
                completion(.success(()))
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
