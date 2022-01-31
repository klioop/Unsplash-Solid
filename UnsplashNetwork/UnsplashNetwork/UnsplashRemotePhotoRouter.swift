//
//  RemotePhotoRouter.swift
//  UnsplashNetwork
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import Alamofire

enum EndPoint {
    case searchPhotos(query: String)
}

final class UnsplashRemotePhotoRouter {
    
    let endpoint: EndPoint
    lazy var path: String = ""
    
    init(endpoint: EndPoint) {
        self.endpoint = endpoint
        createPath()
    }
    
}

extension UnsplashRemotePhotoRouter {
    
    var baseUrl: String {
        "https://api.unsplash.com"
    }
    
    var method: HTTPMethod {
        switch endpoint {
        case .searchPhotos:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    var parameters: Parameters {
        return createParameters()
    }
    
    var destination: URLEncodedFormParameterEncoder.Destination {
        switch endpoint {
        case .searchPhotos:
            return .queryString
        }
    }
    
    var url: URL {
        do {
            return try createuUrl()
        } catch {
            return URL(string: "fail")!
        }
    }
    
    
}

// MARK: - Helpers

extension UnsplashRemotePhotoRouter {
    
    private func createPath() {
        switch endpoint {
        case .searchPhotos:
            path = "search/photos"
        }
    }
    
    private func createParameters() -> [String: Any] {
        var parameters: Parameters = [:]
        
        switch endpoint {
        case let .searchPhotos(query):
            parameters["query"] = query
        }
        
        return parameters
    }
    
    private func createuUrl() throws -> URL {
        var url = try baseUrl.asURL()
        url = url.appendingPathComponent(path)
        
        return url
    }
}
