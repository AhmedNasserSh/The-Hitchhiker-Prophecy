//
//  The_Hitchhiker_ProphecyTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class The_Hitchhiker_ProphecyTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testDigestEncryption() {
        let authData = "1abcd1234"
        let digest = authData.MD5()
        XCTAssertEqual(digest, "ffd275c5130566a2916217b101f26150", "Auth Hash Encryption doesn't work")
    }

}
