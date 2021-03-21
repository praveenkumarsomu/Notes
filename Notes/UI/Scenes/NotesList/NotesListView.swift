//
//  ContentView.swift
//  Notes
//
//  Created by Praveen on 16/3/21.
//

import SwiftUI
/// Notes list view it will display the list of the notes
struct NotesListView: View {
    /// List of notes
    @State private var notes: Notes = []
    /// Binding value to navigate Create new note screen
    @State private var isShowingAddView = false
    /// Error object it will contain the latest error description need to be shown as alert
    @State private var errorDescription: ErrorObject?
    var viewModel: NotesListViewModel!
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(notes, id: \.id) { note in
                        NavigationLink(destination: getCreateNewView(for: note)) {
                            Text(note.title ?? "")
                        }
                    }
                    .onDelete(perform: delete(at:))
                }
                /// Error shown in alert
                .alert(item: $errorDescription) { error -> Alert in
                    Alert(title: Text("Error"), message: Text(error.description), dismissButton: .default(Text("Ok")))
                }
                /// Create new note button
                FloatingButton(text: "+") {
                    isShowingAddView = true
                }
                NavigationLink(destination: getCreateNewView(), isActive: $isShowingAddView) {
                   EmptyView()
                }.hidden()
            }
            /// Get notes from Fire store each time view appeared
            .onAppear(perform: getNotes)
            .navigationTitle("Notes")
        }
    }
}
// MARK:- Get and Delete notes
extension NotesListView {
    func getNotes() {
        viewModel.getNotesCompletion = { result in
            switch result {
            case .success(let notes):
                self.notes = notes
            case .failure(let error):
                errorDescription = ErrorObject(description: error.getMessage())
            }
        }
        viewModel.getNotes()
    }
    func delete(at offsets: IndexSet) {
        let notesList = offsets.map { self.notes[$0] }
        if let note = notesList.first {
            viewModel.deleteNote(note: note)
        }
        notes.remove(atOffsets: offsets)
    }
}
// MARK:- Get create/edit view
extension NotesListView {
    func getCreateNewView(for note: Note? = nil) -> CreateOrEditNoteView {
        var createNoteView: CreateOrEditNoteView!
        if let note = note, let editUsecase = container.resolve(EditNoteUseCase?.self), let usecase = editUsecase {
            let editNoteViewModel = CreateOrEditNoteViewModel(editUseCase: usecase)
            createNoteView = CreateOrEditNoteView(viewModel: editNoteViewModel)
            createNoteView.note = note
        } else if let createNoteUseCase = container.resolve(CreateNoteUseCase?.self), let usecase = createNoteUseCase {
            let createNoteViewModel = CreateOrEditNoteViewModel(usecase: usecase)
            createNoteView = CreateOrEditNoteView(viewModel: createNoteViewModel)
            createNoteView.note = note
        }
        return createNoteView
    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
