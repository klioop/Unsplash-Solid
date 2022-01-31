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
    
    func test_sut_baseUrl() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.baseUrl, baseUrl)
    }
    
    func test_sut_endPoint_rightPath() {
        let sut = makeSUT()
        
        switch sut.endpoint {
        case .searchPhotos:
            XCTAssertEqual(sut.path, searchEndPoint)
        }
    }
    
    func test_sut_endPoint_rightHttpMethod() {
        let sut = makeSUT()
        
        switch sut.endpoint {
        case .searchPhotos:
            XCTAssertEqual(sut.method, .get)
        }
    }
    
    func test_sut_endpoint_rightParameters() {
        let sut = makeSUT()
        
        switch sut.endpoint {
        case .searchPhotos:
            let query = sut.parameters["query"] as! String
            XCTAssertEqual(query, "a")
        }
    }
    
    func test_sut_endpoint_rightDestination() {
        let sut = makeSUT()
        
        switch sut.endpoint {
        case .searchPhotos:
            XCTAssertEqual(sut.destination, .queryString)
        }
    }
    
    func test_sut_endPoint_rightUrl() {
        let sut = makeSUT()
        
        switch sut.endpoint {
        case .searchPhotos:
            XCTAssertEqual(sut.url.absoluteString, baseUrl + "/" + searchEndPoint)
        }
    }
        
    func test_sut_httpHeaders() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.headers.count, 0)
    }
    
    
    
    
    
    
    // MARK: - Helpers
    
    private func makeSUT(endPoint: EndPoint = .searchPhotos(query: "a")) -> UnsplashRemotePhotoRouter {
        return UnsplashRemotePhotoRouter(endpoint: endPoint)
    }
    
}
