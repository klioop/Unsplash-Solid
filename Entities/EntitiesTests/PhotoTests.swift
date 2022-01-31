//
//  PhotoTests.swift
//  EntitiesTests
//
//  Created by klioop on 2022/01/31.
//

import XCTest
@testable import Entities

class PhotoTests: XCTestCase {
    
    func test_twoPhoto_equality() {
        XCTAssertEqual(makeSUT(id: "A"), makeSUT(id: "A"))
        XCTAssertNotEqual(makeSUT(id: "A"), makeSUT(id: "B"))
    }
    
    func test_twoSut_hashable() {
        XCTAssertEqual(makeSUT(id: "A").hashValue, makeSUT(id: "A").hashValue)
        XCTAssertNotEqual(makeSUT(id: "A").hashValue, makeSUT(id: "B").hashValue)
    }
    
    private func makeSUT(id: String) -> Photo {
        return Photo(id: id, author: "", width: 1, height: 0, likes: 0, likedByUser: false, urls: .init(raw: "a", small: "b", regular: "", full: ""))
    }

    
}
