//
//  GlobalContainerTests.swift
//  NotesTests
//
//  Created by Praveen on 21/3/21.
//

import XCTest
@testable import Notes

class GlobalContainerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testResolvingRepository() {
        let notesRepo = container.resolve(NotesRepository?.self)
        XCTAssertNotNil(notesRepo!, "Repository is not registered in container")
    }
    func testResolvingCreateNoteUseCase() {
        let createUsecase = container.resolve(CreateNoteUseCase?.self)
        XCTAssertNotNil(createUsecase!, "Create note use case is not registered in container")
    }
    func testResolvingEditNoteUseCase() {
        let editUsecase = container.resolve(EditNoteUseCase?.self)
        XCTAssertNotNil(editUsecase!, "Edit note use case is not registered in container")
    }
    func testResolvingDeleteNoteUseCase() {
        let deleteUsecase = container.resolve(DeleteNoteUseCase?.self)
        XCTAssertNotNil(deleteUsecase!, "Delete note use case is not registered in container")
    }
    func testResolvingGetNoteUseCase() {
        let getUsecase = container.resolve(GetNotesUseCase?.self)
        XCTAssertNotNil(getUsecase!, "Delete note use case is not registered in container")
    }
}
