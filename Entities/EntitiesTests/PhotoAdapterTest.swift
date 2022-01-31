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
        let photo = Photo(id: "a", author: "", width: 0, height: 0, likes: 0, likedByUser: false, urls: .init(raw: "", small: "", regular: "", full: ""))
        let response = ResponseOfPhotoInfo(id: "a", width: 0, height: 0, likes: 0, likedByUser: false, user: .init(id: "aa", username: "", name: ""), urls: .init(raw: "", full: "", regular: "", small: ""))
        let sut = PhotoAdapter()
        
        XCTAssertEqual(sut.toPhoto(response), photo)
    }
}

