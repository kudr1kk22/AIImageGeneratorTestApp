//
//  BookmarkManagerTests.swift
//  AIImageGeneratorTestAppTests
//
//  Created by Eugene Kudritsky on 4.05.23.
//

import XCTest
@testable import AIImageGeneratorTestApp

final class BookmarkManagerTests: XCTestCase {

    var bookmarkManager: BookmarkManager!

    override func setUp() {
        super.setUp()
        bookmarkManager = BookmarkManager()
    }

    override func tearDown() {
        bookmarkManager = nil
        super.tearDown()
    }

    func testSaveBookmarkImage() {
     
        let name = "test"
        let image = UIImage(systemName: "book")!.pngData()!

        bookmarkManager.saveBookmarkImage(image, withName: name)

        let bookmarkDirectoryURL = bookmarkManager.bookmarkDirectoryURL
        let fileURL = bookmarkDirectoryURL?.appendingPathComponent("\(name).jpg")
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL!.path), "Bookmark image file was not created")

        try? FileManager.default.removeItem(at: fileURL!)
    }

    func testBookmarkDirectoryURL() {
        let bookmarkDirectoryURL = bookmarkManager.bookmarkDirectoryURL
        XCTAssertNotNil(bookmarkDirectoryURL, "Bookmark directory URL is nil")
    }
}
