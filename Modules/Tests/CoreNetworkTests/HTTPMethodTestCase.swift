//
//  File.swift
//  
//
//  Created by Anderson Lentz on 08/04/22.
//

import XCTest
@testable import CoreNetwork

class HTTPMethodTestCase: XCTestCase {
    
    func test_getMethod_returnsCorretRawValue() {
        let sut = HTTPMethod.get
        
        XCTAssertEqual(sut.rawValue, "GET")
    }

}
