//
//  NetworkServiceTests.swift
//  AIImageGeneratorTestAppTests
//
//  Created by Eugene Kudritsky on 4.05.23.
//

import XCTest
@testable import AIImageGeneratorTestApp

final class NetworkServiceTests: XCTestCase {

  var networkService: NetworkService!

     override func setUp() {
         super.setUp()
         networkService = NetworkService()
     }

     override func tearDown() {
         networkService = nil
         super.tearDown()
     }

     func testCreateRequest() {
         let url = URL(string: "https://dummyimage.com/300x300&text=test")!
         let httpMethod: HTTPMethod = .GET

         let expectation = XCTestExpectation(description: "Completion should be called with URLRequest")
         networkService.createRequest(with: url, type: httpMethod) { request in
             XCTAssertEqual(request.url, url)
             XCTAssertEqual(request.httpMethod, httpMethod.rawValue)
             expectation.fulfill()
         }

         wait(for: [expectation], timeout: 5)
     }


}
