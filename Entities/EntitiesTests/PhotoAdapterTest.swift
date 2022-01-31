//
//  PhotoAdapterTest.swift
//  EntitiesTests
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import XCTest
@testable import Entities

class PhotoAdapterTest: XCTestCase {
    
    func test_sut_adapt_responseOfPhotoInfoToPhoto() {
        let photo = photo(id: "a")
        let response = responseOfPhotoInfo(id: "a")
        
        XCTAssertEqual(makeSUT().toPhoto(response), photo)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> PhotoAdapter {
        return PhotoAdapter()
    }
    
    private func photo(id: String) -> Photo {
        return Photo(id: id, author: "", width: 0, height: 0, likes: 0, likedByUser: false, urls: .init(raw: "", small: "", regular: "", full: ""))
    }
    
    private func responseOfPhotoInfo(id: String) -> ResponseOfPhotoInfo {
        return ResponseOfPhotoInfo(id: id, width: 0, height: 0, likes: 0, likedByUser: false, user: .init(id: "aa", username: "", name: ""), urls: .init(raw: "", full: "", regular: "", small: ""))
    }
}


