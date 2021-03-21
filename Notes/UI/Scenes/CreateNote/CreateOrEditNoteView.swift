//
//  CreateNoteView.swift
//  Notes
//
//  Created by Praveen on 20/3/21.
//

import SwiftUI
/// Create or edit note view
struct CreateOrEditNoteView: View {
    var note: Note!
    // MARK:- State variables
    @State private var title: String = ""
    @State private var description: String = ""
    @State private(set) var errorObject: ErrorObject?
    /// View model
    private(set) var viewModel: CreateOrEditNoteViewModel!
    /// presentation mode to dismiss
    @Environment(\.presentationMode) var presentationMode
    /// Returns whether it is editing or creating code
    var isEditingNote: Bool {
        note != nil
    }
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
            }
            Section(header: Text("Description"), content: {
                TextEditor(text: $description)
            })
        }
        .alert(item: $errorObject) { error -> Alert in
            Alert(title: Text("Alert"), message: Text(error.description), dismissButton: .default(Text("Ok")))
        }
        .navigationBarTitle(Text("Create New note"), displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button( isEditingNote ? "Edit" :"Add", action: {
                                    saveNote()
                                })
        ).onAppear(perform: onCreateSetup)
    }
    /// Calls this function on view appear
    func onCreateSetup() {
        bindViewModel()
        title = note?.title ?? ""
        description = note?.description ?? ""
    }
    /// Binds the view model outputs
    func bindViewModel() {
        viewModel.completion = { result in
            switch result {
            case .success(_):
                presentationMode.wrappedValue.dismiss()
            case .failure(let error):
                errorObject = ErrorObject(description: error.getMessage())
            }
        }
    }
}
// MARK:- Save note to FireStore
extension CreateOrEditNoteView {
    func saveNote() {
        guard !title.isEmpty else {
            errorObject = ErrorObject(description: "Title is empty")
            return
        }
        guard !description.isEmpty else {
            errorObject = ErrorObject(description: "Description is empty")
            return
        }
        if isEditingNote {
            viewModel.editNote(note: Note(id: note.id, title: title, description: description))
        } else {
            viewModel.createNote(note: Note(title: title, description: description))
        }
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditNoteView()
    }
}
