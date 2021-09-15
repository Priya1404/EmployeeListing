//
//  EmployeeListingWorkerTests.swift
//  EmployeesBioFourmisTests
//
//  Created by Priya Srivastava on 15/09/21.
//

import XCTest
@testable import EmployeesBioFourmis

class EmployeeListingWorkerTests: XCTestCase {
    
    var listServiceSut: EmployeeListingWorker!
    var expec = XCTestExpectation(description: "FetchList")

    override func setUpWithError() throws {
        listServiceSut = EmployeeListingWorker()
    }

    override func tearDownWithError() throws {
        listServiceSut = nil
    }

    func testEmployeeListing() throws {
        listServiceSut.getEmployeeListing(pageNumber: 2) { [weak self] (listingResponse) in
            let list = listingResponse.data
            if list.count > 0 {
                self?.expec.fulfill()
                XCTAssert(true, "List of User Results found")
            }
        } failure: { (error) in
            XCTFail(error.localizedDescription)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
