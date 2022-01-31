//
//  RemotePhotoRouter.swift
//  UnsplashNetwork
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import Alamofire

enum EndPoint {
    case searchPhotos((query: String, page: Int))
}

final class UnsplashRemotePhotoRouter {
    
    private(set) var endPoint: EndPoint?
    private(set) lazy var path: String = ""
    
    func updateEndPoint(_ endPoint: EndPoint) {
        self.endPoint = endPoint
        createPath()
    }
}

extension UnsplashRemotePhotoRouter {
    
    var baseUrl: String {
        "https://api.unsplash.com"
    }
    
    var method: HTTPMethod {
        switch endPoint {
        case .searchPhotos:
            return .get
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    var parameters: [String: String] {
        return createParameters()
    }
    
    var destination: URLEncodedFormParameterEncoder.Destination {
        switch endPoint {
        case .searchPhotos:
            return .queryString
        default: return .queryString
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
        switch endPoint {
        case .searchPhotos:
            path = "search/photos"
        default:
            break
        }
    }
    
    private func createParameters() -> [String: String] {
        var parameters: [String: String] = [:]
        
        switch endPoint {
        case let .searchPhotos(info):
            parameters["query"] = info.query
            parameters["page"] = "\(info.page)"
            return parameters
        default:
            return parameters
        }
    }
    
    private func createuUrl() throws -> URL {
        var url = try baseUrl.asURL()
        url = url.appendingPathComponent(path)
        
        return url
    }
}
