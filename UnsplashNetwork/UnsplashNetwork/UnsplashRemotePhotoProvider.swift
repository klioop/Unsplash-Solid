//
//  UnsplashRemotePhotoProvider.swift
//  UnsplashNetwork
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import Alamofire
import RxSwift
import Entities

class UnsplashRemotePhotoProvider {
    
    let session: Session
    let remoteRouter: UnsplashRemotePhotoRouter
    let photoAdater: PhotoAdapter
    
    init(session: Session, remoteRouter: UnsplashRemotePhotoRouter) {
        self.session = session
        self.remoteRouter = remoteRouter
        self.photoAdater = PhotoAdapter()
    }
    
    func fetchPhotos(
        with query: String,
        for page: Int
    ) -> Single<Result<Set<Photo>, APIError>>{
        remoteRouter.updateEndPoint(.searchPhotos((query: query, page: page)))
        
        return Single.create { [unowned self] single in
            self.requestWithSession()
                .responseDecodable(of: ResponseOfSearch.self) { result in
                    let code = result.response?.statusCode ?? -1
                    if (200..<300) ~= code {
                        switch result.result {
                        case let .success(response):
                            let photos = Set(response.results.map(photoAdater.toPhoto(_:)))
                            single(.success(.success(photos)))
                        case .failure:
                            single(.success(.failure(.invalid)))
                        }
                    } else {
                        switch code {
                        case 400, 403:
                            single(.success(.failure(.invalid)))
                        default:
                            single(.success(.failure(.invalid)))
                        }
                    }
                    
                }
            return Disposables.create()
        }
            
    }
    
}

// MARK: - Helpers

extension UnsplashRemotePhotoProvider {
    private func requestWithSession() -> DataRequest {
        let encoder = URLEncodedFormParameterEncoder(destination: remoteRouter.destination)
        
        return session.request(
            remoteRouter.url,
            method: remoteRouter.method,
            parameters: remoteRouter.parameters,
            encoder: encoder,
            headers: remoteRouter.headers
        ).validate()
    }
}
