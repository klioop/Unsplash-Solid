//
//  RemotePhotoRouterTest.swift
//  UnsplashNetworkTests
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import XCTest
@testable import UnsplashNetwork

class RemotePhotoRouterTest: XCTestCase {
    
    let baseUrl = "https://api.unsplash.com"
    let searchEndPoint = "search/photos"
    lazy var sut = makeSUT()
    
    func test_sut_baseUrl() {
        XCTAssertEqual(sut.baseUrl, baseUrl)
    }
    
    func test_sut_endPoint_rightPath() {
        sut.updateEndPoint(.searchPhotos(("a", 1)))
        
        switch sut.endPoint {
        case .searchPhotos:
            XCTAssertEqual(sut.path, searchEndPoint)
        default:
            XCTAssertNil(sut.endPoint)
        }
    }
    
    func test_sut_endPoint_rightHttpMethod() {
        sut.updateEndPoint(.searchPhotos(("a", 1)))
        
        switch sut.endPoint {
        case .searchPhotos:
            XCTAssertEqual(sut.method, .get)
        default:
            XCTAssertNil(sut.endPoint)
        }
    }
    
    func test_sut_endpoint_rightParameters() {
        sut.updateEndPoint(.searchPhotos(("a", 1)))
        
        switch sut.endPoint {
        case .searchPhotos:
            let query = sut.parameters["query"]!
            let page = sut.parameters["page"]!
            XCTAssertEqual(query, "a")
            XCTAssertEqual(page, "1")
        default:
            XCTAssertNil(sut.endPoint)
        }
    }
    
    func test_sut_endpoint_rightDestination() {
        sut.updateEndPoint(.searchPhotos(("a", 1)))
        
        switch sut.endPoint {
        case .searchPhotos:
            XCTAssertEqual(sut.destination, .queryString)
        default:
            XCTAssertNil(sut.endPoint)
        }
    }
    
    func test_sut_endPoint_rightUrl() {
        sut.updateEndPoint(.searchPhotos(("a", 1)))
        
        switch sut.endPoint {
        case .searchPhotos:
            XCTAssertEqual(sut.url.absoluteString, baseUrl + "/" + searchEndPoint)
        default:
            XCTAssertNil(sut.endPoint)
        }
    }
        
    func test_sut_httpHeaders() {        
        XCTAssertEqual(sut.headers.count, 0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> UnsplashRemotePhotoRouter {
        return UnsplashRemotePhotoRouter()
    }
    
}
