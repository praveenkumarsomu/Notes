//
//  NotesErrorUseCase.swift
//  NotesTests
//
//  Created by Praveen on 21/3/21.
//

import XCTest
@testable import Notes

class NotesErrorUseCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGenericErrorDescription() {
        XCTAssertEqual("Something went wrong please try again later", NotesError.genericError().getMessage(), "Generic error message is wrong")
    }
    func testIdNotFoundErrorDescription() {
        XCTAssertEqual("Id not found", NotesError.idNotFound().getMessage(), "Id not found error message is wrong")
    }
}
