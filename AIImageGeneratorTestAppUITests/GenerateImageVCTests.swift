//
//  GenerateImageVCTests.swift
//  AIImageGeneratorTestAppUITests
//
//  Created by Eugene Kudritsky on 2.05.23.
//

import XCTest

class GenerateImageVCTests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    app = XCUIApplication()
    app.launch()
  }

  override func tearDown() {
    app = nil
    super.tearDown()
  }

  func testSearchImage() {
    let searchTextField = app.textFields["searchTextField"]
    let createButton = app.buttons["createButton"]
    let imageView = app.images["imageView"]

    // Type the text "apple" into the search text field
    searchTextField.tap()
    searchTextField.typeText("apple")

    // Tap the create button to search for the image
    createButton.tap()

    // Wait for the image to be loaded
    let predicate = NSPredicate(format: "exists == 1")
    let expectation = expectation(for: predicate, evaluatedWith: imageView, handler: nil)
    let result = XCTWaiter().wait(for: [expectation], timeout: 10)
    XCTAssertEqual(result, .completed)

    // Verify that the image is displayed
    XCTAssertTrue(imageView.exists)
  }
}
