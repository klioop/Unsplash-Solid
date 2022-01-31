//
//  UnsplashRemotePhotoProvider.swift
//  UnsplashNetwork
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import Alamofire
import RxSwift

class UnsplashRemotePhotoProvider {
    
    let session: Session
    let remoteRouter: UnsplashRemotePhotoRouter
    
    init(session: Session, remoteRouter: UnsplashRemotePhotoRouter) {
        self.session = session
        self.remoteRouter = remoteRouter
    }
    
    func fetchPhotos() -> Single<Result<[Photo], APIError>>{
        return Single.create { [unowned self] single in
            self.requestWithSession()
                .responseDecodable(of: ResponseOfSearch.self) { result in
                    switch result.result {
                    case let .success(responseOfSearch):
                        single(.success(.success(<#T##[Photo]#>)))
                        
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
